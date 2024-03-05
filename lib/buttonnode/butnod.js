const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

let switchState = 0; // Initialize switch state to 0 (off)

app.post("/switch", (req, res) => {
  const { switchState: newSwitchState } = req.body;

  console.log("Received switch state:", newSwitchState); // Log received switch state

  if (newSwitchState === 0 || newSwitchState === 1) {
    // Check if the received state is valid
    switchState = newSwitchState;
    console.log("Switch state updated to:", switchState); // Log updated switch state
    res.json({ value: switchState }); // Return updated switch state
  } else {
    res.status(400).json({ error: "Invalid switch state" });
  }
});

app.get("/switch", (req, res) => {
  console.log("Sending switch state:", switchState); // Log current switch state
  res.json({ value: switchState }); // Return current switch state
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
