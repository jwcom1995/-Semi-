package com.biz.dao;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dto.BizDto;

import common.JDBCTemplate;

public class BizDao extends JDBCTemplate{
	
	public List<BizDto> selectAll(){
		
		Connection con =getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<BizDto> res = new ArrayList<BizDto>();
		
		String sql = "SELECT * FROM BUSINESS";
		
		try {
			pstm=con.prepareStatement(sql);
			System.out.println("03. query 준비 : "+ sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				BizDto tmp = new BizDto();
				
				tmp.setBizno(rs.getInt(1));
				tmp.setUserno(rs.getInt(2));
				tmp.setUsernm(rs.getString(3));
				tmp.setBiznm(rs.getString(4));
				tmp.setBizaddr(rs.getString(5));
				tmp.setBizcategory(rs.getString(6));
				tmp.setBizcontent(rs.getString(7));
				tmp.setBizpic(rs.getString(8));
				tmp.setBizreg(rs.getDate(9));
				tmp.setBizstatus(rs.getString(10));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	public BizDto selectOne(int bizno){
		
		Connection con =getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		BizDto res = new BizDto();
		
		String sql = "SELECT * FROM BUSINESS WHERE BIZ_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, bizno);
			System.out.println("03. query 준비 : "+ sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {				
				res.setBizno(rs.getInt(1));
				res.setUserno(rs.getInt(2));
				res.setUsernm(rs.getString(3));
				res.setBiznm(rs.getString(4));
				res.setBizaddr(rs.getString(5));
				res.setBizcategory(rs.getString(6));
				res.setBizcontent(rs.getString(7));
				res.setBizpic(rs.getString(8));
				res.setBizreg(rs.getDate(9));
				res.setBizstatus(rs.getString(10));
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	public int delete(int bizno) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = "DELETE FROM BUSINESS WHERE BIZ_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, bizno);
			System.out.println("03.query 준비: "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("error: 3/4단계 failed");
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}
		
	public int insert(BizDto dto){
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = "INSERT INTO BUSINESS VALUES(BIZ_NOSQ.NEXTVAL,?,?,?,?,?,?,?,SYSDATE,'N')";
		
		try {
			pstm=con.prepareStatement(sql);
			
			pstm.setInt(1, dto.getUserno());
			pstm.setString(2, dto.getUsernm());
			pstm.setString(3, dto.getBiznm());
			pstm.setString(4, dto.getBizaddr());
			pstm.setString(5, dto.getBizcategory());
			pstm.setString(6, dto.getBizcontent());
			pstm.setString(7, dto.getBizpic());
			System.out.println("03.query 준비: "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}
		
		return res;
	}
	
	public int statusUpdate(int bizno,String status) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE BUSINESS SET BIZ_STATUS=? WHERE BIZ_NO=?";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, status);
			pstm.setInt(2, bizno);
			System.out.println("03.query 준비: "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			close(pstm);
			close(con);
			System.out.println("05.db 종료\n");
		}		
		return res;
	}
	
		public int multiDelete(String[] list) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		int[] cnt = null;
		
		String sql ="DELETE FROM BUSINESS WHERE BIZ_NO=?";
		try {
			pstm= con.prepareStatement(sql);
			for(int i = 0 ; i<list.length;i++) {
				pstm.setString(1,list[i]);
				pstm.addBatch();
				System.out.println("03.query 준비: "+sql+"(변경할 번호:"+list[i]+")");
			}
		
			cnt=pstm.executeBatch();
			System.out.println("04. query 실행");
			
			//성공: -2, 실패 : -3
			for(int i = 0 ; i <cnt.length;i++) {
				if(cnt[i] == -2) {
					res++;
				}
			}
			if(list.length == res) {
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
			System.out.println("05. db 종료\n");
		}		
		return res;		
	}
}
