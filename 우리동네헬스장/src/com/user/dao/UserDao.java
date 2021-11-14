package com.user.dao;
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

import com.user.dto.UserDto;

public class UserDao {
	public UserDto login(String user_id, String user_pw) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		UserDto res = new UserDto();
		
		String sql = " SELECT * FROM USER_INFO WHERE USER_ID=? AND USER_PW=? AND USER_ENABLED=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, user_id);
			pstm.setString(2, user_pw);
			pstm.setString(3, "N");
			System.out.println("03. query 준비 : " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			
			while(rs.next()) {
				res.setUserno(rs.getInt(1));
				res.setUserid(rs.getString(2));
				res.setUserpw(rs.getString(3));
				res.setUsername(rs.getString(4));
				res.setUsergender(rs.getString(5));
				res.setUserbirthdate(rs.getString(6));
				res.setUseremail(rs.getString(7));
				res.setUserphone(rs.getString(8));
				res.setUserzip(rs.getString(9));
				res.setUseraddr(rs.getString(10));
				res.setRole(rs.getString(11));
				res.setReg(rs.getDate(12));
				res.setUserenabled(rs.getString(13));
				res.setUserwish(rs.getString(14));
				
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n ");
		}
		return res;
	}
	
	public String idChk(String id) {
		Connection con = getConnection();
		PreparedStatement pstm =null;
		ResultSet rs = null;
		String res =null;
		
		String sql ="SELECT * FROM USER_INFO WHERE USER_ID=?";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, id);
			System.out.println("03.query 준비: "+sql);
			
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				res=rs.getString(2);
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
	
	public int insertUser(UserDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		
		String sql = "INSERT INTO USER_INFO VALUES(USER_NOSQ.NEXTVAL,?,?,?,?,?,?,?,?,?,'GU',SYSDATE,'N','')";
		
		try {
			pstm=con.prepareStatement(sql);
			pstm.setString(1, dto.getUserid());
			pstm.setString(2, dto.getUserpw());
			pstm.setString(3, dto.getUsername());
			pstm.setString(4, (dto.getUsergender().equals("남자"))? "M":"F");
			pstm.setString(5, dto.getUserbirthdate());
			pstm.setString(6, dto.getUseremail());
			pstm.setString(7, dto.getUserphone());
			pstm.setString(8, dto.getUserzip());
			pstm.setString(9, dto.getUseraddr());
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
			System.out.println("05.db 종료");
		}
		
		return res;
	}
	public boolean delete(int userno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE USER_INFO SET USER_ENABLED = 'Y' WHERE USER_NO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, userno);
			System.out.println("03. query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
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
			System.out.println("05. db 종료\n");
		}
		return (res>0)?true:false;
	}
	public int update(UserDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE USER_INFO SET USER_NAME=?, USER_ID=?, USER_PW=?, USER_PHONE=?, USER_EMAIL=?, USER_ADDR=? WHERE USER_NO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getUsername());
			pstm.setString(2, dto.getUserid());
			pstm.setString(3, dto.getUserpw());
			pstm.setString(4, dto.getUserphone());
			pstm.setString(5, dto.getUseremail());
			pstm.setString(6, dto.getUseraddr());
			pstm.setInt(7, dto.getUserno());
			System.out.println("03. query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
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
			System.out.println("05. db 종료\n");
		}
		return res;
	}

	public UserDto selectOne(int userno) {

		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		UserDto res = new UserDto();

		String sql ="SELECT * FROM USER_INFO WHERE USER_NO=?";

		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, userno);
			System.out.println("03. query 준비 : " + sql);

			rs = pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");

			while(rs.next()) {
				res.setUserno(rs.getInt(1));
				res.setUserid(rs.getString(2));
				res.setUserpw(rs.getString(3));
				res.setUsername(rs.getString(4));
				res.setUsergender(rs.getString(5));
				res.setUserbirthdate(rs.getString(6));
				res.setUseremail(rs.getString(7));
				res.setUserphone(rs.getString(8));
				res.setUserzip(rs.getString(9));
				res.setUseraddr(rs.getString(10));
				res.setRole(rs.getString(11));
				res.setReg(rs.getDate(12));
				res.setUserenabled(rs.getString(13));
				res.setUserwish(rs.getString(14));
			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05.db 종료");
		}

		return res;
	}

	public String findid(UserDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		String res = "";
		
		String sql = " SELECT * FROM USER_INFO WHERE USER_BIRTHDATE = ? AND USER_EMAIL = ? AND USER_PHONE = ?";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dto.getUserbirthdate());
			pstm.setString(2, dto.getUseremail());
			pstm.setString(3, dto.getUserphone());
			System.out.println("03.query 준비: "+sql);
			
			System.out.println(dto.getUserbirthdate()+" , "+dto.getUseremail()+" , "+dto.getUserphone());
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				res=rs.getString("USER_ID");
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
	
	public int findpw(UserDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		int res = 0;
		
		String sql = " SELECT * FROM USER_INFO WHERE USER_ID = ? AND USER_BIRTHDATE = ? AND USER_EMAIL = ? AND USER_PHONE = ?";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, dto.getUserid());
			pstm.setString(2, dto.getUserbirthdate());
			pstm.setString(3, dto.getUseremail());
			pstm.setString(4, dto.getUserphone());
			System.out.println("03.query 준비: "+sql);
			
			System.out.println(dto.getUserbirthdate()+" , "+dto.getUseremail()+" , "+dto.getUserphone());
			rs=pstm.executeQuery();
			System.out.println("04.query 실행 및 리턴");
			
			while(rs.next()) {
				res=rs.getInt("USER_NO");
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
	public List<UserDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<UserDto> res = new ArrayList<UserDto>();
		
		String sql = "SELECT * FROM USER_INFO";
		
		try {
			pstm=con.prepareStatement(sql);
			System.out.println("03. query 준비");
			
			rs=pstm.executeQuery();
			System.out.println("04. query 실행 및 리턴");
			while(rs.next()) {
				UserDto tmp = new UserDto();
				
				tmp.setUserno(rs.getInt(1));
				tmp.setUserid(rs.getString(2));
				tmp.setUserpw(rs.getString(3));
				tmp.setUsername(rs.getString(4));
				tmp.setUsergender(rs.getString(5));
				tmp.setUserbirthdate(rs.getString(6));
				tmp.setUseremail(rs.getString(7));
				tmp.setUserphone(rs.getString(8));
				tmp.setUserzip(rs.getString(9));
				tmp.setUseraddr(rs.getString(10));
				tmp.setRole(rs.getString(11));
				tmp.setReg(rs.getDate(12));
				tmp.setUserenabled(rs.getString(13));
				tmp.setUserwish(rs.getString(14));
				
				res.add(tmp);
			}
		} catch (SQLException e) {
			System.out.println("error : 3/4단계 failed");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("05. db 종료\n");
		}
		return res;
	}
	
	public int changepw(UserDto dto) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE USER_INFO SET USER_PW=? WHERE USER_NO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getUserpw());
			pstm.setInt(2, dto.getUserno());
			System.out.println("03. query 준비 : " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("04. query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
			} catch (SQLException e) {
				System.out.println("error : query 준비/실행 실패");
				e.printStackTrace();
			} finally {
				close(pstm);
				close(con);
				System.out.println("05. db 종료 \n");
			}
			return res;
	}
	public int multiUpdate(List<UserDto> list) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res=0;
		int[] cnt = null;
		
		//String sql = "UPDATE USER_INFO SET USER_ENABLED=CASE WHEN USER_ENABLED='Y' THEN 'N' WHEN USER_ENABLED='N' THEN 'Y' ELSE 'N' END WHERE USER_NO=?";
		String sql ="UPDATE USER_INFO SET USER_ENABLED=?,USER_ROLE=? WHERE USER_NO=?";
		try {
			pstm= con.prepareStatement(sql);
			for(int i = 0 ; i<list.size();i++) {
				pstm.setString(1,list.get(i).getUserenabled());
				pstm.setString(2, list.get(i).getRole());
				pstm.setInt(3, list.get(i).getUserno());
				pstm.addBatch();
				System.out.println("03.query 준비: "+sql+"(변경할 번호:"+list.get(i).getUserno()+")");
			}
		
			cnt=pstm.executeBatch();
			System.out.println("04. query 실행");
			
			//성공: -2, 실패 : -3
			for(int i = 0 ; i <cnt.length;i++) {
				if(cnt[i] == -2) {
					res++;
				}
			}
			
			if(list.size() == res) {
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
	
	public int roleUpdate(int userno,String role) {
		
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE USER_INFO SET USER_ROLE=? WHERE USER_NO=?";
		
		try {
			pstm = con.prepareStatement(sql);
			
			pstm.setString(1, role);
			pstm.setInt(2, userno);
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
}