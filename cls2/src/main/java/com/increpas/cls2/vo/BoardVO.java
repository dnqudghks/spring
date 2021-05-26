package com.increpas.cls2.vo;

import java.sql.Date;
import java.sql.Time;
import java.text.*;
import java.util.*;

public class BoardVO {
	private int gno, rno, bno, upno, mno, ano, cnt, step;
	private String id, name, title, uptitle, body, ebody, sdate, avatar;
	private Date wdate;
	private Time wtime;
	private ArrayList<FileVO> list;
	
	public int getGno() {
		return gno;
	}
	public void setGno(int gno) {
		this.gno = gno;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public int getAno() {
		return ano;
	}
	public void setAno(int ano) {
		this.ano = ano;
	}
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public int getUpno() {
		return upno;
	}
	public void setUpno(int upno) {
		this.upno = upno;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUptitle() {
		return uptitle;
	}
	public void setUptitle(String uptitle) {
		this.uptitle = uptitle;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getEbody() {
		return ebody;
	}
	public void setEbody(String ebody) {
		this.ebody = ebody.replaceAll("\r\n", "<br>");
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate() {
		SimpleDateFormat form1 = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat form2 = new SimpleDateFormat(" HH:mm:ss");
		sdate = form1.format(wdate) + form2.format(wtime);
	}
	public void setSdate(Date wdate) {
		SimpleDateFormat form1 = new SimpleDateFormat("yyyy/MM/dd");
		sdate = form1.format(wdate);
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	public Time getWtime() {
		return wtime;
	}
	public void setWtime(Time wtime) {
		this.wtime = wtime;
	}
	public ArrayList<FileVO> getList() {
		return list;
	}
	public void setList(ArrayList<FileVO> list) {
		this.list = list;
	}
	
	@Override
	public String toString() {
		return "BoardVO : gno=" + gno + ", rno=" + rno + ", bno=" + bno + ", mno=" + mno + ", ano=" + ano + ", cnt="
				+ cnt + ", step=" + step + ", id=" + id + ", name=" + name + ", title=" + title + ", body=" + body
				+ ", sdate=" + sdate + ", avatar=" + avatar + ", wdate=" + wdate + ", wtime=" + wtime;
	}
	
}