package com.app.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDownServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		String fileName = request.getParameter("fileName");

		File file = new File("F:\\programming\\upload", fileName);
		String filePath = file.getPath();
		// String FilePath = downloadPath + fileName;

		byte b[] = new byte[4096];
		FileInputStream in = new FileInputStream(filePath);

		String mimeType = getServletContext().getMimeType(filePath);
		System.out.println("sMimeType>>>" + mimeType);

		if (mimeType == null) {
			mimeType = "application/octet-stream";
		}
		response.setContentType(mimeType);

		// �ѱ� ���ε�
		String encoding = new String(fileName.getBytes("UTF-8"), "8859_1");

		response.setHeader("Content-Disposition", "attachment; filename= " + encoding);

		ServletOutputStream out = response.getOutputStream();
		int numRead;

		// ����Ʈ �迭b�� 0�� ���� numRead�� ���� �������� ���
		while ((numRead = in.read(b, 0, b.length)) != -1) {
			out.write(b, 0, numRead);
		}
		out.flush();
		out.close();
		in.close();

	}// end
}// end class
