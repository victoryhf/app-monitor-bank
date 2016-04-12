package com.springmvc_mybatis.tools;

import java.io.PrintStream;
import java.io.PrintWriter;

public class CheckException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return super.getMessage();
	}

	
	
	public CheckException() {
		super();
		// TODO Auto-generated constructor stub
	}



	public CheckException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		// TODO Auto-generated constructor stub
	}



	public CheckException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}



	public CheckException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}



	public CheckException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}



	@Override
	public void printStackTrace() {
		// TODO Auto-generated method stub
		super.printStackTrace();
	}

	@Override
	public void printStackTrace(PrintStream s) {
		// TODO Auto-generated method stub
		super.printStackTrace(s);
	}

	@Override
	public void printStackTrace(PrintWriter s) {
		// TODO Auto-generated method stub
		super.printStackTrace(s);
	}

	
}
