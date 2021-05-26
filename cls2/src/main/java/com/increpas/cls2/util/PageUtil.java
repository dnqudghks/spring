package com.increpas.cls2.util;

public class PageUtil {
	
	private int nowPage;	// 현재 보고있는 페이지
	private int totalPage;	// 총 페이지 수
	private int total;		// 총 게시물 수를 기억할 변수
	
	private int pageRow;	// 한페이지에 보여질 게시물 수
	private int pageGroup;	// 이동가능한 페이지 수
	
	private int startPage;	// 화면에 보여질 시작 페이지 번호
	private int endPage;	// 화면에 보여질 마지막 페이지 번호
	
	private int startCont;	// 현재 페이지에서 보여질 시작 게시물 행번호(nownum)
	private int endCont;	// 현재 페이지에서 보여질 마지막 게시물 행번호(rownum)
	
	public PageUtil() {
		nowPage = 1;
	}
	
	public PageUtil(int nowPage, int total) {
		this(nowPage, total, 3, 3);
	}
	
	public PageUtil(int nowPage, int total, int pageRow, int pageGroup) {
		setPage(nowPage, total, pageRow, pageGroup);
	}
	
	public void setPage(int nowPage, int total, int pageRow, int pageGroup) {
		this.nowPage = nowPage;
		this.total = total;
		this.pageRow = pageRow;
		this.pageGroup = pageGroup;
		calcPage();
		calcStartPage();
		calcEndPage();
		calcCont();
	}
	
	// totalPage 계산함수
	public void calcPage() {
		totalPage = (total % pageRow) == 0 ? ((total == 0) ? 1 : total / pageRow) : (total / pageRow + 1) ;
		if(nowPage > totalPage) {
			nowPage = totalPage;
		}
	}
	
	// 시작페이지 계산함수
	public void calcStartPage() {
		int tmpGroup = (nowPage - 1) / pageGroup;
		startPage = tmpGroup * pageGroup + 1;
		/*
		1 2 3
		4 5 6
		7 8 9
		....
		
		13
		
		1 2
		
		*/
	}
	
	// 마지막 페이지 계산 함수
	public void calcEndPage() {
		int tmpGroup = (nowPage - 1) / pageGroup;
		endPage = (tmpGroup + 1) * pageGroup;
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
	// 시작 게시물번호 계산함수
	public void calcCont() {
		startCont = (nowPage - 1) * pageRow + 1;
		endCont = (nowPage * pageRow) > total ? total : (nowPage * pageRow);
	}
	
	// getters & setters
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getPageRow() {
		return pageRow;
	}
	public void setPageRow(int pageRow) {
		this.pageRow = pageRow;
	}
	public int getPageGroup() {
		return pageGroup;
	}
	public void setPageGroup(int pageGroup) {
		this.pageGroup = pageGroup;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getStartCont() {
		return startCont;
	}
	public void setStartCont(int startCont) {
		this.startCont = startCont;
	}
	public int getEndCont() {
		return endCont;
	}
	public void setEndCont(int endCont) {
		this.endCont = endCont;
	}

	@Override
	public String toString() {
		return "PageUtil : nowPage=" + nowPage + ", totalPage=" + totalPage + ", total=" + total + ", pageRow=" + pageRow
				+ ", pageGroup=" + pageGroup + ", startPage=" + startPage + ", endPage=" + endPage + ", startCont="
				+ startCont + ", endCont=" + endCont ;
	}
	
}