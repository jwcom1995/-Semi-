package com.usedask.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.usedask.dto.UsedaskDto;

import common.JDBCTemplate;

public class UsedaskDao extends JDBCTemplate{
	
	public List<UsedaskDto> selectAll(int usedno){
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs =null;
		List<UsedaskDto> res = new ArrayList<UsedaskDto>();
		
		String sql = "SELECT * FROM USED_ASK WHERE USED_NO=? AND USK_GPSQ=1";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, usedno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				UsedaskDto tmp = new UsedaskDto();
				
				tmp.setUskno(rs.getInt(1));
				tmp.setUsedno(rs.getInt(2));
				tmp.setUsktype(rs.getString(3));
				tmp.setUskgpno(rs.getInt(4));
				tmp.setUskgpsq(rs.getInt(5));
				tmp.setUserid(rs.getString(6));
				tmp.setUsktitle(rs.getString(7));
				tmp.setUskcontent(rs.getString(8));
				tmp.setUskreg(rs.getDate(9));
				tmp.setUskstatus(rs.getString(10));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	
	public UsedaskDto selectOne(int uskno){
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs =null;
		UsedaskDto res = new UsedaskDto();
		
		String sql = "SELECT * FROM USED_ASK WHERE USK_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, uskno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {				
				res.setUskno(rs.getInt(1));
				res.setUsedno(rs.getInt(2));
				res.setUsktype(rs.getString(3));
				res.setUskgpno(rs.getInt(4));
				res.setUskgpsq(rs.getInt(5));
				res.setUserid(rs.getString(6));
				res.setUsktitle(rs.getString(7));
				res.setUskcontent(rs.getString(8));
				res.setUskreg(rs.getDate(9));
				res.setUskstatus(rs.getString(10));
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db종료\n");
		}		
		return res;
	}
	
	public int insert(UsedaskDto dto) {
		
		Connection con=getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql ="INSERT INTO USED_ASK VALUES(USK_NOSQ.NEXTVAL,?,?,USK_GPNOSQ.NEXTVAL,1,?,?,?,SYSDATE,'N')";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, dto.getUsedno());
			pstm.setString(2, dto.getUsktype());
			pstm.setString(3,dto.getUserid());
			pstm.setString(4, dto.getUsktitle());
			pstm.setString(5, dto.getUskcontent());
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04.query 실행");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db종료 \n");
		}
		return res;
	}
	public List<UsedaskDto> selectAnswerAll(int usedno,int uskgpno){
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs =null;
		List<UsedaskDto> res = new ArrayList<UsedaskDto>();
		
		String sql = "SELECT * FROM USED_ASK WHERE USED_NO=? AND USK_GPNO=? AND USK_GPSQ>1";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, usedno);
			pstm.setInt(2, uskgpno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				UsedaskDto tmp = new UsedaskDto();
				
				tmp.setUskno(rs.getInt(1));
				tmp.setUsedno(rs.getInt(2));
				tmp.setUsktype(rs.getString(3));
				tmp.setUskgpno(rs.getInt(4));
				tmp.setUskgpsq(rs.getInt(5));
				tmp.setUserid(rs.getString(6));
				tmp.setUsktitle(rs.getString(7));
				tmp.setUskcontent(rs.getString(8));
				tmp.setUskreg(rs.getDate(9));
				tmp.setUskstatus(rs.getString(10));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4 단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db종료\n");
		}
		
		return res;
	}
	public int answerUpdate(int parentgpno, int parentgpsq) {
		Connection con = getConnection();
		PreparedStatement pstm=null;
		int res=0;
		
		String sql = "UPDATE USED_ASK SET USK_GPSQ = USK_GPSQ+1"
				+ " WHERE USK_GPNO=? AND USK_GPSQ>?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, parentgpno);
			pstm.setInt(2, parentgpsq);
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db종류 \n");
		}
		
		return res;
	}
	
	public int answerInsert(UsedaskDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql="INSERT INTO USED_ASK VALUES(USK_NOSQ.NEXTVAL,?,?,?,?,?,?,?,SYSDATE,'N')";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, dto.getUsedno());
			pstm.setString(2,"answer");
			pstm.setInt(3,dto.getUskgpno());
			pstm.setInt(4, dto.getUskgpsq()+1);
			pstm.setString(5, dto.getUserid());
			pstm.setString(6, dto.getUsktitle());
			pstm.setString(7, dto.getUskcontent());
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db종료 \n");			
		}
		return res;
	}
	
	public int uskstausUpdate(int uskno) {
		
		Connection con = getConnection();
		PreparedStatement pstm =null;
		int res = 0;
		
		String sql = "UPDATE USED_ASK SET USK_STATUS='Y' WHERE USK_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, uskno);
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("error : 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		return res;
	}
}
