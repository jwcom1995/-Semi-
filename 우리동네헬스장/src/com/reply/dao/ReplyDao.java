package com.reply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.qna.dto.QnaDto;
import com.reply.dto.ReplyDto;

import common.JDBCTemplate;

public class ReplyDao extends JDBCTemplate{
	
	public List<ReplyDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<ReplyDto> res = new ArrayList<ReplyDto>();
		
		String sql = " SELECT * FROM QNA_REPLY ORDER BY QA_RENO DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("03.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				ReplyDto dto = new ReplyDto();
				dto.setQareno(rs.getInt(1));
				dto.setQano(rs.getInt(2));
				dto.setTitletab(rs.getInt(3));
				dto.setRetitle(rs.getString(4));
				dto.setContent(rs.getString(5));
				
				res.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}
	
	public List<ReplyDto> reList(int qano){	
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<ReplyDto> res = new ArrayList<ReplyDto>();
		
	
		String sql = " SELECT * FROM QNA_REPLY WHERE QA_NO=? ORDER BY QA_RENO";
		
		try {
			
			
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, qano);
			System.out.println("03.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			
			while(rs.next()) {
				ReplyDto rdto = new ReplyDto();
				rdto.setQareno(rs.getInt(1));
				rdto.setQano(rs.getInt(2));
				rdto.setTitletab(rs.getInt(3));
				rdto.setContent(rs.getString(4));
				rdto.setRetitle(rs.getString(5));
				
				
				res.add(rdto);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
			
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}
	
	public ReplyDto selectOne(int qareno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		ReplyDto res = new ReplyDto();
		
		String sql = " SELECT * FROM QNA_REPLY WHERE QA_RENO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, qareno);
			System.out.println("03.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			if(rs.next()) {
				res.setQareno(rs.getInt(1));
				res.setQano(rs.getInt(2));
				res.setTitletab(rs.getInt(3));
				res.setContent(rs.getString(4));
				res.setRetitle(rs.getString(5));
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}
	
	public int insert(ReplyDto dto) {

		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " INSERT INTO QNA_REPLY VALUES(QA_RENOSQ.NEXTVAL,?,TITLETAB.NEXTVAL,?,? ) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, dto.getQano());
			pstm.setString(2, dto.getContent());
			pstm.setString(3, dto.getRetitle());
			
			System.out.println("03.query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}

	public int update(ReplyDto rdto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;

		String sql = " UPDATE QNA_REPLY SET TITLE=?,CONTENT=? WHERE QA_RENO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1,rdto.getRetitle());
			pstm.setString(2, rdto.getContent());
			pstm.setInt(3, rdto.getQareno());
			System.out.println("03.query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}
	
	public int delete(int qareno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " DELETE FROM QNA_REPLY WHERE QA_RENO=? ";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, qareno);
			System.out.println("03.query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		return res;
	}
}
