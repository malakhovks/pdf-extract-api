import log from "../libs/log";
import multer from "multer";
import fs from "fs";
import * as PDFTOTEXT from "child_process";

const UPLOAD = multer({dest: 'public/uploads/'}).single('pdf');

module.exports = app => {

	app.get("/api/pdftotext", (req, res) => {
		res.json({status: "PDF to text/html API"});

		//TODO res.flush() (node:28258) DeprecationWarning: OutgoingMessage.flush is deprecated. Use flushHeaders instead.
		// res.flush();

	});

	app.post("/api/pdftotext", UPLOAD, (req, res) => {

		log.debug(req.headers);

		if (req.file.originalname.toLowerCase().indexOf(".pdf") === -1) {
			res.sendStatus(400);
			fs.unlink(req.file.path);
			return log.error("400 Error: File upload only supports .pdf filetype");
		}

		PDFTOTEXT.exec("pdftotext -layout -nopgbrk -raw -eol unix " + req.file.path + " -", {maxBuffer: 1000 * 1024},
			(error, stdout, stderr) => {

				if (error) {
					fs.unlink(req.file.path);
					res.sendStatus(500);
					log.error(error);
					return log.error(stderr);
				}

				log.info(req.file.originalname + " Done!");
				log.debug("\n" + stdout);

				fs.unlink(req.file.path);
				res.type('text/html');
				res.status(200).send(stdout.trim());
				res.flush();

			})


	});
};