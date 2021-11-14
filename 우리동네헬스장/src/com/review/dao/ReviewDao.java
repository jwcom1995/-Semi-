package com.review.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.review.dto.ReviewDto;

import common.JDBCTemplate;

public class ReviewDao extends JDBCTemplate{
	
	public List<ReviewDto> selectAll(int centerno){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<ReviewDto> res = new ArrayList<ReviewDto>();
		
		String sql = "SELECT * FROM REVIEW WHERE CENTER_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, centerno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				ReviewDto tmp = new ReviewDto();
				
				tmp.setReviewno(rs.getInt(1));
				tmp.setCenterno(rs.getInt(2));
				tmp.setReviewwriter(rs.getString(3));
				tmp.setReviewgrade(rs.getDouble(4));
				tmp.setReviewcontent(rs.getString(5));
				tmp.setReviewreg(rs.getDate(6));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	
	public ReviewDto selectOne(int reviewno){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ReviewDto res = new ReviewDto();
		
		String sql = "SELECT * FROM REVIEW WHERE REVIEW_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, reviewno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				
				res.setReviewno(rs.getInt(1));
				res.setCenterno(rs.getInt(2));
				res.setReviewwriter(rs.getString(3));
				res.setReviewgrade(rs.getDouble(4));
				res.setReviewcontent(rs.getString(5));
				res.setReviewreg(rs.getDate(6));
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	public int insert (ReviewDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = "INSERT INTO REVIEW VALUES(REVIEW_NOSQ.NEXTVAL,?,?,?,?,SYSDATE)";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, dto.getCenterno());
			pstm.setString(2, dto.getReviewwriter());
			pstm.setDouble(3, dto.getReviewgrade());
			pstm.setString(4, dto.getReviewcontent());
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error : 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	
	public int delete (int reviewno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = "DELETE FROM REVIEW WHERE REVIEW_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, reviewno);
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error : 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
}
