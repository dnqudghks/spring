package com.increpas.cls2.vo;

import java.util.Date;
import java.sql.*;
import java.text.*;

public class FileVO {
	private int rno, fno, bno, mno, cnt;
	private long len;
	private String oriname, savename, dir, sdate;
	private Date fdate;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public long getLen() {
		return len;
	}
	public void setLen(long len) {
		this.len = len;
	}
	public String getOriname() {
		return oriname;
	}
	public void setOriname(String oriname) {
		this.oriname = oriname;
	}
	public String getSavename() {
		return savename;
	}
	public void setSavename(String savename) {
		this.savename = savename;
	}
	public String getDir() {
		return dir;
	}
	public void setDir(String dir) {
		this.dir = dir;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate() {
		SimpleDateFormat form = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		sdate = form.format(fdate);
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public Date getFdate() {
		return fdate;
	}
	public void setFdate(Date fdate) {
		this.fdate = fdate;
		setSdate();
	}
}