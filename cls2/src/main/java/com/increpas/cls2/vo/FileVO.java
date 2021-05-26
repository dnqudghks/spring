package com.increpas.cls2.vo;

import java.sql.*;
import java.text.SimpleDateFormat;

public class FileVO {
	private int rno, fno, bno, mno, cnt;
	private long len;
	private String oriname, savename, dir, sdate;
	private Date fdate;
	private Time ftime;
	
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
	public String setSdate(Date fdate) {
		SimpleDateFormat form1 = new SimpleDateFormat("yyyy/MM/dd");
		sdate = form1.format(fdate);
		return form1.format(fdate);
	}
	public String setSdate(Time ftime) {
		SimpleDateFormat form1 = new SimpleDateFormat("HH:mm:ss");
		return form1.format(ftime);
	}
	public void setSdate() {
		this.sdate = setSdate(fdate) + " " + setSdate(ftime);
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public Date getFdate() {
		return fdate;
	}
	public void setFdate(Date fdate) {
		this.fdate = fdate;
	}
	public Time getFtime() {
		return ftime;
	}
	public void setFtime(Time ftime) {
		this.ftime = ftime;
	}
}
