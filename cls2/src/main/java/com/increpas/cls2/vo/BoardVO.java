package com.increpas.cls2.vo;

import java.util.Date;

import org.springframework.web.multipart.*;

import java.text.*;
import java.util.*;

public class BoardVO {
	private int gno, rno, bno, upno, mno, ano, cnt, step;
	private String id, name, title, uptitle, body, ebody, sdate, savename, avatar;
	private Date wdate;
	private ArrayList<FileVO> list;
	private MultipartFile upfile;
	private MultipartFile[] file;
	
	/*
		업로드된 파일을 기억할 변수는
			MultipartFile
		이라는 클래스 형태로 만들어야 한다.
		그러면 그 안에 스트림 형태로 파일의 내용이 기억되게 된다.
		
		이때 주의사항
			만약 name 속성값이 하나이면 일반변수로 만들어 주면 되고
			같은 name 속성값을 사용하는 태그가 여러개면 (다중업로드의 경우)
			배열변수로 만들어주면 된다.
	 */
	
	public MultipartFile getUpfile() {
		return upfile;
	}
	public void setUpfile(MultipartFile upfile) {
		this.upfile = upfile;
	}
	public MultipartFile[] getFile() {
		return file;
	}
	public void setFile(MultipartFile[] file) {
		this.file = file;
	}
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
		SimpleDateFormat form = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");
		sdate = form.format(wdate);
	}
	public void setSdate(Date wdate) {
		SimpleDateFormat form1 = new SimpleDateFormat("yyyy/MM/dd");
		sdate = form1.format(wdate);
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getSavename() {
		return savename;
	}
	public void setSavename(String savename) {
		this.savename = savename;
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
		setSdate();
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
				+ ", sdate=" + sdate + ", avatar=" + avatar + ", wdate=" + wdate ;
	}
	
}