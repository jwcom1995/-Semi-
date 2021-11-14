package com.used.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.pic.dto.PicDto;
import com.used.dto.UsedDto;
import com.wish.dto.WishDto;

import common.JDBCTemplate;

public class UsedDao extends JDBCTemplate{
	
	public List<UsedDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<UsedDto> res = new ArrayList<UsedDto>();
		
		String sql = "SELECT * FROM USED_BOARD";
		
		try {
			pstm=con.prepareStatement(sql);
			System.out.println("03. query 준비: " + sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				UsedDto dto = new UsedDto();
				
				dto.setUsedno(rs.getInt(1));
				dto.setUsedtitle(rs.getString(2));
				dto.setUserid(rs.getString(3));
				dto.setUserno(rs.getInt(4));
				dto.setUsedaddr(rs.getString(5));
				dto.setUsedprice(rs.getString(6));
				dto.setUsedcategory(rs.getString(7));
				dto.setUsedcenternm(rs.getString(8));
				dto.setUsedcontent(rs.getString(9));
				dto.setUsedreg(rs.getDate(10));
				dto.setUsedstatus(rs.getString(11));
				
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	public UsedDto selectOne(int usedno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		UsedDto res = new UsedDto();
		
		String sql = "SELECT * FROM USED_BOARD WHERE USED_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, usedno);
			System.out.println("03. query 준비 : "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				
				res.setUsedno(rs.getInt(1));
				res.setUsedtitle(rs.getString(2));
				res.setUserid(rs.getString(3));
				res.setUserno(rs.getInt(4));
				res.setUsedaddr(rs.getString(5));
				res.setUsedprice(rs.getString(6));
				res.setUsedcategory(rs.getString(7));
				res.setUsedcenternm(rs.getString(8));
				res.setUsedcontent(rs.getString(9));
				res.setUsedreg(rs.getDate(10));
				res.setUsedstatus(rs.getString(11));
				
			}
		} catch (SQLException e) {
			System.out.println("error : 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료");
		}
		return res;
	}
	
	public int insert(UsedDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql ="INSERT INTO USED_BOARD VALUES (USED_NOSQ.NEXTVAL,?,?,?,?,?,?,?,?,SYSDATE,'N')";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, dto.getUsedtitle());
			pstm.setString(2, dto.getUserid());
			pstm.setInt(3, dto.getUserno());
			pstm.setString(4, dto.getUsedaddr());
			pstm.setString(5, dto.getUsedprice());
			pstm.setString(6, dto.getUsedcategory());
			pstm.setString(7, dto.getUsedcenternm());
			pstm.setString(8, dto.getUsedcontent());
			System.out.println("03. query 준비 : "+sql);
			
			res=pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			} else {
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
	
	public int delete (int usedno) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = "DELETE FROM USED_BOARD WHERE USED_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, usedno);
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
	
	public int update(UsedDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = "UPDATE USED_BOARD SET USED_TITLE=?,USED_PRICE=?,USED_CATEGORY=?,USED_CONTENT=? WHERE USED_NO=?";
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, dto.getUsedtitle());
			pstm.setString(2, dto.getUsedprice());
			pstm.setString(3, dto.getUsedcategory());
			pstm.setString(4, dto.getUsedcontent());
			pstm.setInt(5, dto.getUsedno());
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
	
	public int updateStatus (int usedno, String status) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = "UPDATE USED_BOARD SET USED_STATUS=? WHERE USED_NO=?";
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, status);
			pstm.setInt(2, usedno);
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
	
	public int selectno(String usedtitle) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int res=0;
		
		System.out.println(usedtitle);
		String sql = " SELECT * FROM USED_BOARD WHERE USED_TITLE = ?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1,usedtitle);
			System.out.println("03.query 준비: "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 준비");
			
			while(rs.next()) {
				res = rs.getInt("USED_NO");
			}
			
			
			
		} catch (SQLException e) {
			System.out.println("3/4단계 오류");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	
	public int insert_pic(int usedno,String imgname,String imgpath) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = " INSERT INTO USED_PIC VALUES(?,UPIC_NOSQ.NEXTVAL,?,?)";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setInt(1, usedno);
			pstm.setString(2, imgname);
			pstm.setString(3, imgpath);
			System.out.println("03.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("04.query 실행 및 준비");
			
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
	
		public List<PicDto> selectAllPic(){	
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;		
		List<PicDto> res = new ArrayList<PicDto>();
		
		String sql = "SELECT * FROM USED_PIC WHERE(PIC_NO) IN (SELECT MIN(PIC_NO) FROM USED_PIC GROUP BY USED_NO)";
		
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
	
	public List<PicDto> selectPics(int usedno){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;		
		List<PicDto> res = new ArrayList<PicDto>();
		
		String sql = "SELECT * FROM USED_PIC WHERE USED_NO=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setInt(1, usedno);
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

public int insertWish(WishDto dto) {

		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;

		String sql = " INSERT INTO USER_WISH VALUES(?,?, SYSDATE, 'Y',?) ";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getLoginid());
			pstm.setInt(2, dto.getTitleno());
			pstm.setString(3, dto.getType());
			System.out.println("03. query 준비 : " + sql);

			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");

			if (res > 0) {

				commit(con);
			} else {
				rollback(con);
			}
		} catch (SQLException e) {
			System.out.println("error : 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}


	public List<WishDto> selectWishAll(String login_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<WishDto> res = new ArrayList<WishDto>();

		String sql = " SELECT A.USED_NO, A.USER_ID, B.TYPE, A.USED_TITLE ";
		sql += "FROM USED_BOARD A ";
		sql += "LEFT JOIN USER_WISH B ON (A.USED_NO = B.TITLE_NO ) ";
		sql += "WHERE B.TYPE = 'U' AND B.LOGIN_ID = ? AND B.USE_YN = 'Y' ";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, login_id);
			System.out.println("03. query 준비: " + sql);

			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");

			while (rs.next()) {
				WishDto dto = new WishDto();

				dto.setTitleno(rs.getInt(1));
				dto.setLoginid(rs.getString(2));
				dto.setType(rs.getString(3));
				dto.setUsedtitle(rs.getString(4));
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	public List<WishDto> selectCenterWishAll(String login_id) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<WishDto> res = new ArrayList<WishDto>();

		String sql = " SELECT A.CENTER_NO, A.USER_ID, B.TYPE, A.CENTER_NAME ";
		sql += "FROM CENTER A ";
		sql += "LEFT JOIN USER_WISH B ON (A.CENTER_NO = B.TITLE_NO ) ";
		sql += "WHERE B.TYPE = 'C' AND B.LOGIN_ID = ? AND B.USE_YN = 'Y' ";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, login_id);
			System.out.println("03. query 준비: " + sql);

			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");

			while (rs.next()) {
				WishDto dto = new WishDto();

				dto.setTitleno(rs.getInt(1));
				dto.setLoginid(rs.getString(2));
				dto.setType(rs.getString(3));
				dto.setUsedtitle(rs.getString(4));
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}

	public WishDto selectOne(String login_id, String used_no, String type) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		WishDto res = new WishDto();

		String sql = "SELECT * FROM USER_WISH WHERE LOGIN_ID=? AND USE_YN = 'Y' AND TITLE_NO=? AND TYPE=? ";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, login_id);
			pstm.setString(2, used_no);
			pstm.setString(3, type);
			System.out.println("03. query 준비 : " + sql);

			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");

			while (rs.next()) {

				res.setLoginid(rs.getString(1));
				res.setTitleno(rs.getInt(2));

			}
		} catch (SQLException e) {
			System.out.println("error : 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료");
		}
		return res;
	}

	public int updateWish(WishDto wish) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;

		String sql = " UPDATE USER_WISH SET USE_YN='N' WHERE LOGIN_ID=? AND TITLE_NO=? AND TYPE=? ";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, wish.getLoginid());
			pstm.setInt(2, wish.getTitleno());
			pstm.setString(3, wish.getType());
			System.out.println("03. query 준비 : " + sql);

			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");

			if (res > 0) {
				commit(con);
			} else {
				rollback(con);
			}

		} catch (SQLException e) {
			System.out.println("3/4 단계 에러 ");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("05. DB 종료\n");
		}
		return res;
	}
	
	public List<UsedDto> selectWriter(String userid){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<UsedDto> res = new ArrayList<UsedDto>();
		
		String sql = "SELECT * FROM USED_BOARD WHERE USER_ID=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, userid);
			System.out.println("03. query 준비: " + sql);
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				UsedDto dto = new UsedDto();
				
				dto.setUsedno(rs.getInt(1));
				dto.setUsedtitle(rs.getString(2));
				dto.setUserid(rs.getString(3));
				dto.setUserno(rs.getInt(4));
				dto.setUsedaddr(rs.getString(5));
				dto.setUsedprice(rs.getString(6));
				dto.setUsedcategory(rs.getString(7));
				dto.setUsedcenternm(rs.getString(8));
				dto.setUsedcontent(rs.getString(9));
				dto.setUsedreg(rs.getDate(10));
				dto.setUsedstatus(rs.getString(11));
				
				res.add(dto);
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	public int multiDelete(String[] list) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		int[] cnt = null;
		
		String sql ="DELETE FROM USED_BOARD WHERE USED_NO=?";
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
