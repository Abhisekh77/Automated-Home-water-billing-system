const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const PORT = 3000;

app.use(bodyParser.json());

let switchState = '';

app.post("/switch", (req, res) => {
  const { switchState: newSwitchState } = req.body;
  
  console.log('Received switch state:', newSwitchState); // Log received switch state
  
  if (newSwitchState === 'on' || newSwitchState === 'off') {
    switchState = newSwitchState;
    console.log('Switch state updated to:', switchState); // Log updated switch state
    res.json({ value: switchState === 'on' ? 1 : 0 }); // Return value based on switch state
  } else {
    res.status(400).json({ error: "Invalid switch state" });
  }
});

app.get("/switch", (req, res) => {
  console.log('Sending switch state:', switchState); // Log current switch state
  res.json({ value: switchState === 'on' ? 1 : 0 }); // Return value based on current switch state
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
