package com.center.dao;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.center.dto.CenterDto;
import com.pic.dto.PicDto;
import com.user.dto.UserDto;

import common.JDBCTemplate;


public class CenterDao extends JDBCTemplate{

	//센터 목록
	public List<CenterDto> selectAll(){
		Connection con = getConnection();
		Statement stmt = null;
		ResultSet rs = null;
		List<CenterDto> res = new ArrayList<CenterDto>();
		
		String sql = " SELECT * FROM CENTER ORDER BY CENTER_NO DESC";
		
		try {
			stmt = con.createStatement();
			System.out.println("03. query 준비: " + sql);
			
			rs = stmt.executeQuery(sql);
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				CenterDto tmp = new CenterDto();
				
				tmp.setCenterno(rs.getInt(1));
				tmp.setCentername(rs.getString(2));
				tmp.setUserid(rs.getString(3));
				tmp.setCenteraddr(rs.getString(4));
				tmp.setCenterprice(rs.getString(5));
				tmp.setCentercategory(rs.getString(6));
				tmp.setCentergrade(rs.getDouble(7));
				tmp.setCenterintro(rs.getString(8));
				tmp.setCentercontent(rs.getString(9));
				tmp.setCenterophour(rs.getString(10));
				tmp.setCenterpro(rs.getString(11));
				tmp.setCenterreg(rs.getDate(12));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			close(rs);
			close(stmt);
			close(con);
			System.out.println("05. db 종료\n");
		}
		
		return res;
	}
	
	public CenterDto selectOne(int centerno) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		CenterDto res = new CenterDto();
		
		String sql = " SELECT * FROM CENTER WHERE CENTER_NO = ?";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, centerno);
			System.out.println("03. query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				res.setCenterno(rs.getInt(1));
				res.setCentername(rs.getString(2));
				res.setUserid(rs.getString(3));
				res.setCenteraddr(rs.getString(4));
				res.setCenterprice(rs.getString(5));
				res.setCentercategory(rs.getString(6));
				res.setCentergrade(rs.getDouble(7));
				res.setCenterintro(rs.getString(8));
				res.setCentercontent(rs.getString(9));
				res.setCenterophour(rs.getString(10));
				res.setCenterpro(rs.getString(11));
				res.setCenterreg(rs.getDate(12));
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		
		return res;
	}
	
	public int centerdetail_writer(CenterDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
	
		int res =0;
		
		String sql = "INSERT INTO CENTER VALUES(CENTER_NOSQ.NEXTVAL,?,?,?,?,?,0,?,?,?,?,SYSDATE)";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dto.getCentername());
			pstm.setString(2, dto.getUserid());
			pstm.setString(3, dto.getCenteraddr());
			pstm.setString(4, dto.getCenterprice());
			pstm.setString(5, dto.getCentercategory());
			pstm.setString(6, dto.getCenterintro());
			pstm.setString(7, dto.getCentercontent());
			pstm.setString(8, dto.getCenterophour());
			pstm.setString(9, dto.getCenterpro());
			System.out.println("03.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
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
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int delete (int centerno) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql = "DELETE FROM CENTER WHERE CENTER_NO=?";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, centerno);
			System.out.println("03.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
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
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int update (CenterDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res =0;
		
		String sql = "UPDATE CENTER SET CENTER_PRICE=?,CENTER_CATEGORY=?,CENTER_INTRO=?,CENTER_CONTENT=?,CENTER_OPHOUR=?,CENTER_PROGRAM=? WHERE CENTER_NO=?";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1,dto.getCenterprice());
			pstm.setString(2, dto.getCentercategory());
			pstm.setString(3, dto.getCenterintro());
			pstm.setString(4, dto.getCentercontent());
			pstm.setString(5, dto.getCenterophour());
			pstm.setString(6, dto.getCenterpro());
			pstm.setInt(7, dto.getCenterno());
			System.out.println("03.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
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
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int insert_pic(int centerno,String imgname,String imgpath) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = " INSERT INTO CENTER_PIC VALUES(?,CPIC_NOSQ.NEXTVAL,?,?)";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setInt(1, centerno);
			pstm.setString(2, imgname);
			pstm.setString(3, imgpath);
			System.out.println("03.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
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
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int selectno(String centername) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int res=0;
		
		System.out.println(centername);
		String sql = " SELECT * FROM CENTER WHERE CENTER_NAME = ?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1,centername);
			System.out.println("03.query 준비: "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 준비");
			
			while(rs.next()) {
				res = rs.getInt("CENTER_NO");
			}
					
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public List<PicDto> selectAllPic(){
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;		
		List<PicDto> res = new ArrayList<PicDto>();
		
		String sql = "SELECT * FROM CENTER_PIC WHERE(PIC_NO) IN (SELECT MIN(PIC_NO) FROM CENTER_PIC GROUP BY CENTER_NO)";
		
		try {
			pstm=con.prepareStatement(sql);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				PicDto tmp = new PicDto();
				
				tmp.setBoardno(rs.getInt(1));
				tmp.setPicno(rs.getInt(2));
				tmp.setPicname(rs.getString(3));
				tmp.setPicpath(rs.getString(4));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	
	public List<PicDto> selectPics(int centerno){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;		
		List<PicDto> res = new ArrayList<PicDto>();
		
		String sql = "SELECT * FROM CENTER_PIC WHERE CENTER_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, centerno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				PicDto tmp = new PicDto();
				
				tmp.setBoardno(rs.getInt(1));
				tmp.setPicno(rs.getInt(2));
				tmp.setPicname(rs.getString(3));
				tmp.setPicpath(rs.getString(4));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error: 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료 \n");
		}
		return res;
	}
	
	public int updateReviewgrade(int centerno) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = "UPDATE CENTER SET CENTER_GRADE=(SELECT (ROUND(AVG(REVIEW_GRADE),1)) FROM REVIEW WHERE CENTER_NO=?) WHERE CENTER_NO=?";
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1,centerno);
			pstm.setInt(2, centerno);
			System.out.println("03. query 준비 : "+ sql);
			
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
	
	public int multiDelete(String[] list) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		int[] cnt = null;
		
		String sql ="DELETE FROM CENTER WHERE CENTER_NO=?";
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