package com.main.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.qna.dao.QnaDao;
import com.qna.dto.QnaDto;
import com.reply.dao.ReplyDao;
import com.reply.dto.ReplyDto;
import com.user.dao.UserDao;
import com.user.dto.UserDto;


@WebServlet("/MainController")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getParameter("command");
		System.out.println("[command : " + command + "]");		
		
		UserDao dao = new UserDao();
		QnaDao udao = new QnaDao();
		ReplyDao rdao = new ReplyDao();
			
		if(command.equals("updatestart")) {
			int userno = Integer.parseInt(request.getParameter("userno"));
			dispatch("mypage_update.jsp",request,response);
			
		}else if(command.equals("update")) {
			int userno = Integer.parseInt(request.getParameter("userno"));
			String name = request.getParameter("name");
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String addr = request.getParameter("addr");
			
			UserDto dto = new UserDto();
			dto.setUserno(userno);
			dto.setUsername(name);
			dto.setUserid(id);
			dto.setUserpw(pw);
			dto.setUserphone(phone);
			dto.setUseremail(email);
			dto.setUseraddr(addr);
			
			int res = dao.update(dto);
			
			if(res>0) {
				jsResponse("회원 수정 성공","MainController?command=updateinfo&userno="+userno,response);

			}else {
				jsResponse("회원 수정 실패","MainController?command=update",response);
			}
			
			
		}else if(command.equals("qna")) {
			String qatype = request.getParameter("qatype");
			
			if(qatype == "") {
				qatype = "1";
			}
			
			List<QnaDto> list = udao.selectAll();
			List<QnaDto> faqlist = udao.selectFaq();
			
			request.setAttribute("list", list);
			request.setAttribute("faqlist", faqlist);
			RequestDispatcher disp = request.getRequestDispatcher("qna.jsp");
			disp.forward(request, response);
			
		}else if(command.equals("selectone")) {
			int qano = Integer.parseInt(request.getParameter("qano"));
			
			QnaDto dto = udao.selectOne(qano);
			
			request.setAttribute("dto", dto);
			RequestDispatcher dis = request.getRequestDispatcher("question_board_selectone.jsp");
			dis.forward(request, response);
			
		}else if(command.equals("getlist")) {
			String qatype = request.getParameter("qatype");

			List<QnaDto> getlist = udao.selectType(qatype);
			
			request.setAttribute("getlist", getlist);
			RequestDispatcher disp = request.getRequestDispatcher("faq_qa_type.jsp");
			disp.forward(request, response);
			
		}else if(command.equals("writeform")) {
			response.sendRedirect("question_board_write.jsp");
			
		}else if(command.equals("boardwrite")) {
			int qagpsq = Integer.parseInt(request.getParameter("qa_gpsq"));
			String qauserid = request.getParameter("user_id");
			int qauserno = Integer.parseInt(request.getParameter("user_no"));
			String qatitle = request.getParameter("title");
			String qacontent = request.getParameter("content");
			String qatype = request.getParameter("qa_type");
			
			QnaDto dto = new QnaDto();
			dto.setQagpsq(qagpsq);
			dto.setUserid(qauserid);
			dto.setUserno(qauserno);
			dto.setQatitle(qatitle);
			dto.setQacontent(qacontent);
			dto.setQatype(qatype);
			
			int res = udao.insert(dto);
			if(res>0) {
				dispatch("MainController?command=qna",request,response);
			}else {
				dispatch("MainController?command=writeform",request,response);
			}
			
		}else if(command.equals("updateform")) {
			int qano = Integer.parseInt(request.getParameter("qano"));
			
			QnaDto dto = udao.selectOne(qano);
			request.setAttribute("dto", dto);
			dispatch("question_board_update.jsp", request, response);
			
		}else if(command.equals("boardupdate")) {
			int qano = Integer.parseInt(request.getParameter("qano"));
			
			String qatitle = request.getParameter("qatitle");
			String qacontent = request.getParameter("qacontent");
			
			QnaDto dto = new QnaDto();
			
			dto.setQatitle(qatitle);
			dto.setQacontent(qacontent);
			dto.setQano(qano);
			
			int res = udao.update(dto);
			 
			if(res>0) {
				dispatch("MainController?command=qna",request,response);
			}else {
				dispatch("MainController?command=selectone&qano="+qano,request,response);
			}
			
		}else if(command.equals("delete")) {
			int qano = Integer.parseInt(request.getParameter("qano"));
			
			int res = udao.delete(qano);
			
			if(res>0) {
				dispatch("MainController?command=qna", request, response);
			}else {
				dispatch("MainController?command=detail&qano="+qano, request, response);
			}
			
		}else if(command.equals("answerdelete")) {
			int qareno = Integer.parseInt(request.getParameter("qareno"));
			
			ReplyDto rdto = new ReplyDto();
			
			int res = rdao.delete(qareno);
			
			if(res>0) {
				dispatch("MainController?command=qna", request, response);
			}else {
				dispatch("MainController?command=detail&qareno="+qareno, request, response);
			}
			
		}else if(command.equals("answerform")) {
			int qano = Integer.parseInt(request.getParameter("qano"));
			
			QnaDto dto = udao.selectOne(qano);
			request.setAttribute("dto", dto);
			
			RequestDispatcher dis = request.getRequestDispatcher("reply_answer_write.jsp");
			dis.forward(request, response);
			
		}else if(command.equals("answerupdateform")) {
			int qareno = Integer.parseInt(request.getParameter("qareno"));
			
			ReplyDto rdto = rdao.selectOne(qareno);
			request.setAttribute("rdto", rdto);
			dispatch("reply_answer_update.jsp", request, response);
		
		}else if(command.equals("answerwrite")) {	
			int qano = Integer.parseInt(request.getParameter("qano"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			int titletab = Integer.parseInt(request.getParameter("titletab"));
			
			ReplyDto rdto = new ReplyDto();
			rdto.setQano(qano);
			rdto.setTitletab(titletab);
			rdto.setRetitle(title);
			rdto.setContent(content);
			
			int res = rdao.insert(rdto);
			
			if(res>0) {
				
				QnaDto dto = new QnaDto();
				dto.setQano(qano);
				
				int res2 = udao.updatefaq(dto);
				
				if(res2>0) {
					dispatch("MainController?command=qna",request,response);
				}else {
					dispatch("MainController?command=answerform",request,response);
				}
			}else {
				dispatch("MainController?command=answerform",request,response);
			}
			
		}else if(command.equals("answerupdate")) {
			int qareno = Integer.parseInt(request.getParameter("qareno"));
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			ReplyDto rdto = new ReplyDto();
			rdto.setRetitle(title);
			rdto.setContent(content);
			rdto.setQareno(qareno);
			
			int res = rdao.update(rdto);
			 
			if(res>0) {
				dispatch("MainController?command=qna",request,response);
			}else {
				dispatch("MainController?command=answerwrite&qareno="+qareno,request,response);
			}
			
		
			
		}else if(command.equals("deleteinfo")) {
			int userno = Integer.parseInt(request.getParameter("userno"));
			
			boolean res = dao.delete(userno);
			
			if(res) {
				jsResponse("회원 탈퇴 성공","usercontroller?command=logout",response);
			}else {
				jsResponse("회원 탈퇴 실패","MainController?command=update",response);
			}
		}else if(command.equals("updateinfo")) {
			int userno = Integer.parseInt(request.getParameter("userno"));
		
			UserDto loginUser = dao.selectOne(userno);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser",loginUser);
			dispatch("main.jsp",request,response);
			
		} else if(command.equals("adminpage")) {
			
			String act = request.getParameter("act");
			
			request.setAttribute("act", act);
			dispatch("admin_main.jsp",request,response);
		}
	}

	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher(url);
		dis.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void jsResponse(String msg, String url,HttpServletResponse response) throws IOException {
		String s = "<script type='text/javascript'>"+"alert('"+msg+"');"+"location.href='"+url+"';"+"</script>";
		
		PrintWriter out = response.getWriter();
		out.print(s);
	}

}
