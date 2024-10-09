/**
 * Main function that orchestrates the gathering of inventory data and sending the email.
 */
function main() {
    var triggers = ScriptApp.getProjectTriggers();
  for (var i = 0; i < triggers.length; i++) {
   if (triggers[i + 1]){
    ScriptApp.deleteTrigger(triggers[i+1]);
   } else{
     break;
   }
  }
   const usedInventory = iterateThroughusedInventory();
   if (usedInventory.length > 0) {
     const emailBody = compileInventoryEmail(usedInventory);
     sendEmail(emailBody);
   } else {
     console.log("No inventory to send.");
   }
 }
 
 /**
  * Iterates through the "usedInventory" on a Google Sheet and returns an array of items that match criteria.
  */
 function iterateThroughusedInventory() {
   const sheet = SpreadsheetApp.getActive().getSheetByName("Sheet1");
   const data = sheet.getDataRange().getValues();
   return data.filter(row => row[1] === true); // second column holds a true/false flag for inclusion
 }
 
 /**
  * Compiles the usedInventory data into a string formatted for email.
  * @param {Array} usedInventory - The inventory data to compile into an email.
  * @return {string} The compiled email body.
  */
 function compileInventoryEmail(usedInventory) {
   let completeInventory = "";
 
   usedInventory.forEach((item, i) => {
     const itemDetails = [
       "Item Type",
       "Item Description",
       "Item Serial Number",
       "Item Condition Description",
       "Price",
       "Warranty",
       "Link to Photos"
     ];
 
     let itemString = itemDetails.map((detail, index) => {
       const value = item[5 + index]; // Adjust index based on your data structure
       if (detail === "Link to Photos") {
         return `${detail}: <a href="${value}">${value}</a>`;
       } if (detail === "Warranty") {
         return `${detail}: ${value} years`;
       } if (detail === "Price") {
         return `${detail}: $${value}`;
       } else {
         return `${detail}: ${value}`;
       }
     }).join('<br>') + '<br><br>';
     
     completeInventory += itemString;
   });
   console.log(completeInventory)
   return completeInventory;
 }
 
 /**
  * Sends an email with the compiled inventory details.
  * @param {string} body - The body of the email to send.
  */
 function sendEmail(body) {
   const recipient = 'x@gmail.com, y@gmail.com'; // Specify the recipient's email address
   const subject = 'Weekly Used Inventory';
   MailApp.sendEmail(recipient, subject, "", {htmlBody: body});
 }
 
 