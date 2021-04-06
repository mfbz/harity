const fs = require("fs");
const path = require("path");

// Get emojis array from json unicode dataset
const emojis = JSON.parse(fs.readFileSync(path.join(__dirname, "./data/emojis.json")));

// Dataset from this https://datahub.io/core/unicode-emojis#resource-unicode-emojis_zip
// only not flags
// only fully qualified
// only neutral yellow skin tone, we are all equal
// only 4 bytes emojis
const data = emojis
  .filter((e) => e.Group !== "Flags")
  .filter((e) => e.Group !== "Symbols")
  .filter((e) => e.Status === "fully-qualified")
  .filter((e) => e.Name.indexOf("skin") === -1)
  .filter((e) => encodeURIComponent(e.Representation).split("%").length - 1 === 4)
  .map((e) => e.Representation);
const dataStr = data.reduce((result, d) => result + d, "");

console.log("Count: " + data.length);
console.log(encodeURIComponent(dataStr).replace(/%/g, "\\x"));
console.log(dataStr);
