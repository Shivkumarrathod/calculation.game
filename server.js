import express from 'express';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

dotenv.config();

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const app = express();
const port = process.env.PORT || 3000;

app.use(express.static(path.join(__dirname, "client/dist")));
app.get('/{*splat}', (req, res) => {
  res.sendFile(path.join(__dirname, 'client/distindex.html'));
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});