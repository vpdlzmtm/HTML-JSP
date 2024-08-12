package com.hrd.app;

public class Note {
	private int num;
	private String log;
	private String head;
	private String id;
	@Override
	public String toString() {
		return "Note [num=" + num + ", log=" + log + ", head=" + head + ", id=" + id + "]";
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getLog() {
		return log;
	}
	public void setLog(String log) {
		this.log = log;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Note(int num, String log, String head, String id) {
		super();
		this.num = num;
		this.log = log;
		this.head = head;
		this.id = id;
	}

}
