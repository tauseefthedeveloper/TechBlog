package com.techBlog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {
	public static boolean deleteFile(String path) {
		boolean f=false;

		try {
			File file=new File(path);
			f=file.delete();
		} catch (Exception e) {
			System.out.println(e);
		}

		return f;
	}
	public static boolean saveFile(InputStream is,String path) {
		boolean f=false;

		try {
			byte b[]=new byte[is.available()];
			is.read(b);
			FileOutputStream fis=new FileOutputStream(path);
			fis.write(b);
			fis.flush();
			fis.close();
			is.close();
			f=true;
		} catch (Exception e) {
			System.out.println(e);
		}

		return f;

	}

}
