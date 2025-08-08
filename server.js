import express from "express";
import { spawn } from "child_process";

const app = express();
app.use(express.json({ limit: "10mb" }));

app.post("/mcp", (req, res) => {
  // Avvia MCP server Shopify in stdio mode
  const child = spawn("npx", ["-y", "@shopify/dev-mcp@latest"], { stdio: ["pipe", "pipe", "inherit"] });

  // Invia i dati in input al processo MCP
  child.stdin.write(JSON.stringify(req.body));
  child.stdin.end();

  let output = "";
  child.stdout.on("data", (data) => {
    output += data.toString();
  });

  child.on("close", () => {
    res.type("application/json").send(output);
  });

  child.on("error", (err) => {
    console.error("Errore MCP:", err);
    res.status(500).send({ error: err.message });
  });
});

app.get("/", (req, res) => {
  res.send("Shopify MCP HTTP Bridge attivo!");
});

const PORT = process.env.PORT || 8802;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 MCP HTTP Bridge in ascolto su porta ${PORT}`);
});
