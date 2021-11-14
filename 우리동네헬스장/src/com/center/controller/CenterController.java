package com.center.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.biz.dao.BizDao;
import com.biz.dto.BizDto;
import com.center.dao.CenterDao;
import com.center.dto.CenterDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.pic.dto.PicDto;
import com.review.dao.ReviewDao;
import com.review.dto.ReviewDto;
import com.user.dao.UserDao;
import com.user.dto.UserDto;
import com.used.dao.UsedDao;
import com.used.dto.UsedDto;
import com.wish.dto.WishDto;

@WebServlet("/CenterController")
public class CenterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String command= request.getParameter("command");
		System.out.println("[command: "+command+"]");
		
		CenterDao dao = new CenterDao();
		UserDao udao = new UserDao();
		BizDao bdao = new BizDao();
		ReviewDao rdao = new ReviewDao();
		
		if(command.equals("centerlist")) {
			
			List<CenterDto> centerlist = dao.selectAll();
			List<PicDto> piclist =dao.selectAllPic();
			
			request.setAttribute("centerlist", centerlist);
			request.setAttribute("piclist", piclist);
			RequestDispatcher dispatch = request.getRequestDispatcher("center_list.jsp");
			dispatch.forward(request, response);
			
		}else if (command.equals("centerdetail")){
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			CenterDto dto = dao.selectOne(centerno);
			List<ReviewDto> reviewList = rdao.selectAll(centerno);
			List<PicDto> piclist = dao.selectPics(centerno);
			UsedDao DAO = new UsedDao();

			request.setAttribute("centerDto", dto);
			//리뷰 있는지 확인
			if(reviewList !=null) {
				request.setAttribute("reviewList", reviewList);
			}
			//사진 있는지 확인
			if(piclist != null) {
				request.setAttribute("piclist", piclist);
			}

			UserDto loginUser = (UserDto) request.getSession().getAttribute("loginUser");

			if(loginUser == null) {
				UsedDto usedDTO = DAO.selectOne(centerno); 
				request.setAttribute("usedDTO", usedDTO);
				
			}else {

			String login_id = loginUser.getUserid();
			String type = "C";
			String center_no = request.getParameter("centerno");
			
			WishDto WishDto = DAO.selectOne(login_id, center_no, type);
			
			
			// if(login_id != null && used_no != null) {
			System.out.println(WishDto.getLoginid());

			// 1. WISH 테이블에 login_id & used_no 로 조회했을 때
			// 데이터 O -> request.setAttribute("wish", 1);
			// 데이터 X -> request.setAttribute("wish", 0);

			if (WishDto.getLoginid() != null) {
				request.setAttribute("wish", 1);
			} else {
				request.setAttribute("wish", 0);
				}
			}

			RequestDispatcher dispatch = request.getRequestDispatcher("center_detail.jsp");
			dispatch.forward(request, response);
			
		} else if(command.equals("review_write_form")) {
			
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			
			request.setAttribute("centerno", centerno);
			RequestDispatcher dispatch = request.getRequestDispatcher("center_review_write.jsp");
			dispatch.forward(request, response);
		} else if(command.equals("review_write")) {
			
			HttpSession session = request.getSession();
			UserDto loginUser = (UserDto)session.getAttribute("loginUser");
			
			ReviewDto rdto = new ReviewDto();
			
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			String writer = loginUser.getUserid();
			double grade = Double.parseDouble(request.getParameter("star_range"));
			String content = request.getParameter("reviewcontent");
			content = content.replace("\r\n","<br>");
			
			rdto.setCenterno(centerno);
			rdto.setReviewwriter(writer);
			rdto.setReviewgrade(grade);
			rdto.setReviewcontent(content);
			
			int res = rdao.insert(rdto);
			int res2 = dao.updateReviewgrade(centerno);
			if(res>0) {
				jsResponse("리뷰가 등록되었습니다.","CenterController?command=centerdetail&centerno="+centerno,response);
			} else {
				jsResponse("리뷰등록이 실패하였습니다","CenterController?command=review_write_form&centerno="+centerno,response);
			}
	
		}else if(command.equals("centerwriteform")){
			response.sendRedirect("center_write.jsp");
		}
		else if(command.equals("centerdetail_writer")) {			
			
			String centername = "";
			String userid="";
			String centeraddr = "";
			String centerprice = "";
			String centercategory = "";
			String centerintro = "";
			String centercontent = "";
			String centerophour = "";
			String centerpro = "";
			
			String imgpath = ""; //이미지 경로 초기화
			String imgname = ""; //이미지 이름 초기화
			
			String uploadpath = request.getRealPath("download"); //upload파일에 실제 경로 설정
			
			int res=0;
			
			try {
				MultipartRequest multi = new MultipartRequest(request, uploadpath,10*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
				
				centername = multi.getParameter("centernm");
				userid = multi.getParameter("userid");
				centeraddr = multi.getParameter("centeraddr");
				centerprice = multi.getParameter("centerprice");
				
				if(multi.getParameter("health") != null) {
					if(centercategory.length()==0) {centercategory += multi.getParameter("health");
					}else {centercategory += ","+multi.getParameter("health");}						
				}
				if(multi.getParameter("pilates") != null) {
					if(centercategory.length()==0) {centercategory += multi.getParameter("pilates");
					}else {centercategory += ","+multi.getParameter("pilates");}						
				}
				if(multi.getParameter("yoga") != null) {
					if(centercategory.length()==0) {centercategory += multi.getParameter("yoga");
					}else {centercategory += ","+multi.getParameter("yoga");}						
				}
				if(multi.getParameter("crossfit") != null) {
					if(centercategory.length()==0) {centercategory += multi.getParameter("crossfit");
					}else {centercategory += ","+multi.getParameter("crossfit");}						
				}
				if(multi.getParameter("etc") != null) {
					if(centercategory.length()==0) {centercategory += multi.getParameter("etc");
					}else {centercategory += ","+multi.getParameter("etc");}						
				}
				centerintro = multi.getParameter("centerintro");
				centercontent = multi.getParameter("centercontent");
				centerophour = multi.getParameter("centerophour");
				centerpro = multi.getParameter("centerpro");
				
				
			
				CenterDto dto = new CenterDto(centername, userid,centeraddr, centerprice, centercategory, centerintro, centercontent, centerophour, centerpro);
			
				res = dao.centerdetail_writer(dto);
			
				int rs = dao.selectno(centername); //centerno호출
				System.out.println(rs);
				
			
				Enumeration files =multi.getFileNames(); //파일명정보를 배열로 만듬
				
				while(files.hasMoreElements()) { //다음 요소가 있으면 반복
					String imgfile = (String)files.nextElement(); //파일명정보 Enumeration 의 다음요소를 imgfile에저장
					imgpath = multi.getFilesystemName(imgfile);
					imgname = multi.getOriginalFileName(imgfile);
						
					res = dao.insert_pic(rs, imgname, imgpath);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
				
			if(res>0) {
				response.sendRedirect("CenterController?command=centerlist");
			}else {
				response.sendRedirect("CenterController?command=centerwriteform");
			}
			
		} else if(command.equals("review_detail")) {
			
			int reviewno = Integer.parseInt(request.getParameter("reviewno"));
			String loginid = request.getParameter("loginid");
			
			ReviewDto reviewDto = rdao.selectOne(reviewno);
			
			request.setAttribute("loginid", loginid);
			request.setAttribute("reviewDto", reviewDto);
			dispatch("center_review_detail.jsp",request,response);
		} else if(command.equals("review_delete")) {
			
			int reviewno = Integer.parseInt(request.getParameter("reviewno"));
			
			int res = rdao.delete(reviewno);
			
			String msg;
			
			if(res>0) {
				msg="리뷰가 삭제되었습니다.";
			} else {
				msg="리뷰 삭제를 실패하였습니다.\n 다시 시도해주세요.";
			}
			
			//열었던 팝업창 닫기
			String s = "<script type='text/javascript'>"
					+"window.opener.location.reload();"
					+"window.close();"
					+"alert('"+msg+"');"
					+ "</script>";
			PrintWriter out = response.getWriter();
			out.print(s);
			
		} else if(command.equals("centerdelete")) {
			
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			
			int res = dao.delete(centerno);
			
			if(res>0) {
				jsResponse("게시글이 성공적으로 삭제되었습니다.","CenterController?command=centerlist",response);
			}else {
				jsResponse("게시글 삭제가 실패하였습니다. \n 다시 시도해주세요..","CenterController?command=centerdetail&centerno="+centerno,response);
			}
			
		} else if(command.equals("centerupdateform")) {
			
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			
			CenterDto centerDto = dao.selectOne(centerno);
			
			request.setAttribute("centerDto", centerDto);
			dispatch("center_update.jsp",request,response);
			
		} else if(command.equals("centerupdate")) {
			
			int centerno = Integer.parseInt(request.getParameter("centerno"));
			
			String centerprice= request.getParameter("centerprice");
			String centercategory="";
			String centerintro= request.getParameter("centerintro");
			String centercontent=request.getParameter("centercontent");
			String centerophour = request.getParameter("centerophour");
			String centerpro = request.getParameter("centerpro");
			
			if(request.getParameter("health") != null) {
				if(centercategory.length()==0) {centercategory += request.getParameter("health");
				}else {centercategory += ","+request.getParameter("health");}						
			}
			if(request.getParameter("pilates") != null) {
				if(centercategory.length()==0) {centercategory += request.getParameter("pilates");
				}else {centercategory += ","+request.getParameter("pilates");}						
			}
			if(request.getParameter("yoga") != null) {
				if(centercategory.length()==0) {centercategory += request.getParameter("yoga");
				}else {centercategory += ","+request.getParameter("yoga");}						
			}
			if(request.getParameter("crossfit") != null) {
				if(centercategory.length()==0) {centercategory += request.getParameter("crossfit");
				}else {centercategory += ","+request.getParameter("crossfit");}						
			}
			if(request.getParameter("etc") != null) {
				if(centercategory.length()==0) {centercategory += request.getParameter("etc");
				}else {centercategory += ","+request.getParameter("etc");}						
			}
			
			CenterDto dto = new CenterDto();
			
			dto.setCenterno(centerno);
			dto.setCenterprice(centerprice);
			dto.setCentercategory(centercategory);
			dto.setCenterintro(centerintro);
			dto.setCentercontent(centercontent);
			dto.setCenterophour(centerophour);
			dto.setCenterpro(centerpro);
			
			int res = dao.update(dto);
			
			if(res>0) {
				jsResponse("게시글 수정이 성공적으로 완료되었습니다.","CenterController?command=centerdetail&centerno="+centerno,response);
			}else {
				jsResponse("게시글 수정이 실패하였습니다. \n 다시 시도해주세요.","CenterController?command=centerdetail&centerno="+centerno,response);
			}
			
		} else if(command.equals("centerlist_ajax")) {
			
			List<CenterDto> centerlist = dao.selectAll();
			
			JSONArray jarr = new JSONArray();
			
			for(int i =0 ; i <centerlist.size();i++) {
				JSONObject tmp = new JSONObject();
				tmp.put("no", centerlist.get(i).getCenterno());
				tmp.put("name", centerlist.get(i).getCentername());
				tmp.put("writer", centerlist.get(i).getUserid());
				tmp.put("reg", centerlist.get(i).getCenterreg().toString());
				jarr.add(tmp);
			}
			response.setContentType("application/x-json; charset=utf-8");
			response.getWriter().print(jarr);
		} else if(command.equals("multi_delete")) {
			
			String[] centernoList = request.getParameterValues("chk");
			
			if(centernoList == null || centernoList.length == 0) {
				jsResponse("하나 이상 체크해주세요!", "MainController?command=adminpage&act=center", response);
			}
			else {
			int res = dao.multiDelete(centernoList);
			
			if(res>0) {
				jsResponse("선택한 게시글(들)이 삭제되었습니다.","MainController?command=adminpage&act=center",response);
			} else {
				jsResponse("선택한 게시글(들) 삭제 실패하였습니다.\n 다시 시도해주세요.","MainController?command=adminpage&act=center",response);
			}
			}
		}
	}

	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(url);
		dispatch.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}
	
	private void jsResponse(String msg,String url, HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"
				+ "alert('"+msg+"');"
				+ "location.href='"+url+"';"
				+ "</script>";
		PrintWriter out = response.getWriter();
		out.print(s);
	}
}
