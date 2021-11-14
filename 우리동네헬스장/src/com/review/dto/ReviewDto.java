package com.review.dto;

import java.util.Date;

public class ReviewDto {
	private int reviewno;
	private int centerno;
	private String reviewwriter;
	private double reviewgrade;
	private String reviewcontent;
	private Date reviewreg;
	
	public ReviewDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReviewDto(int reviewno, int centerno, String reviewwriter, double reviewgrade, String reviewcontent,
			Date reviewreg) {
		super();
		this.reviewno = reviewno;
		this.centerno = centerno;
		this.reviewwriter = reviewwriter;
		this.reviewgrade = reviewgrade;
		this.reviewcontent = reviewcontent;
		this.reviewreg = reviewreg;
	}

	public int getReviewno() {
		return reviewno;
	}

	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}

	public int getCenterno() {
		return centerno;
	}

	public void setCenterno(int centerno) {
		this.centerno = centerno;
	}

	public String getReviewwriter() {
		return reviewwriter;
	}

	public void setReviewwriter(String reviewwriter) {
		this.reviewwriter = reviewwriter;
	}

	public double getReviewgrade() {
		return reviewgrade;
	}

	public void setReviewgrade(double reviewgrade) {
		this.reviewgrade = reviewgrade;
	}

	public String getReviewcontent() {
		return reviewcontent;
	}

	public void setReviewcontent(String reviewcontent) {
		this.reviewcontent = reviewcontent;
	}

	public Date getReviewreg() {
		return reviewreg;
	}

	public void setReviewreg(Date reviewreg) {
		this.reviewreg = reviewreg;
	}
	
	
}
