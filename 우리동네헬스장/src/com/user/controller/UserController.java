package com.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.used.dao.UsedDao;
import com.used.dto.UsedDto;
import com.user.dao.UserDao;
import com.user.dto.UserDto;
import com.user.message.messageApp;

@WebServlet("/usercontroller")
public class UserController extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");
      
      String command = request.getParameter("command");
      System.out.println("[ command : " + command + "]");
      
      UserDao dao = new UserDao();
      UsedDao usedDao = new UsedDao();
      BizDao bdao = new BizDao();
      
      if(command.equals("idChk")) {
         String myid=request.getParameter("id");
         String res = dao.idChk(myid);
         
         boolean idnotused=true;
         
         //중복되는 경우가 있을경우
         if(res!=null){ 
            idnotused=false;
         }
         
         response.sendRedirect("idchk.jsp?idnotused="+idnotused);
      }else if(command.equals("login")){
         String user_id = request.getParameter("user_id");
         String user_pw = request.getParameter("user_pw");
         
         UserDto loginUser = dao.login(user_id, user_pw);
         
         if(loginUser.getUserid() != null) {
            
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", loginUser);
            session.setMaxInactiveInterval(60*60);
         
            if(loginUser.getRole().equals("M")) {
               dispatch("main.jsp",request,response);
            }else if(loginUser.getRole().equals("BU")) {
               dispatch("main.jsp",request,response);
            }else if(loginUser.getRole().equals("DM")) {
               dispatch("main.jsp",request,response);
            }else if(loginUser.getRole().equals("GU")) {
               dispatch("main.jsp",request,response);
            }
         
         }else {
            jsResponse("로그인 실패","main.jsp",response);
         
         }

      }else if(command.equals("insertuser")) {
         String myid = request.getParameter("myid");
         String mypw = request.getParameter("mypw");
         String myname = request.getParameter("myname");
         String myzip = request.getParameter("myzipcode");
         String mygender = request.getParameter("mygender");
         String myaddr = request.getParameter("myaddr1")+" "+request.getParameter("myaddr2");
         String mybirth = request.getParameter("mybirthyy")+"/"+request.getParameter("mybirthmm")+"/"+request.getParameter("mybirthdd");
         String myphone = request.getParameter("myphone");
         String myemail = request.getParameter("myemail");
         
         UserDto dto = new UserDto();
         dto.setUserid(myid);
         dto.setUserpw(mypw);
         dto.setUsername(myname);
         dto.setUserzip(myzip);
         dto.setUsergender(mygender);
         dto.setUserbirthdate(mybirth);
         dto.setUseraddr(myaddr);
         dto.setUserphone(myphone);
         dto.setUseremail(myemail);
         
         
         int res = dao.insertUser(dto);
       
         if(res>0) {
            jsResponse("회원 가입 성공", "usercontroller?command=loginform", response);
         }else {
            jsResponse("회원 가입 실패", "usercontroller?command=registform", response);
         }
      }else if(command.equals("registform")) {
         response.sendRedirect("join_user.jsp");
      }else if(command.equals("naver_login")) {
         response.sendRedirect("naverlogin.jsp");
      
      }else if(command.equals("logout")) {
      HttpSession session = request.getSession();
      session.invalidate();
      response.sendRedirect("main.jsp");
      
      }else if(command.equals("findidform")){
    	  response.sendRedirect("login_find_id_input.jsp");
      }else if(command.equals("findpwform")) {
    	  response.sendRedirect("login_find_pw_input.jsp");
      }else if(command.equals("loginform")) {
         response.sendRedirect("login.jsp");
      }else if(command.equals("findid")) {
    	  String mybirth = request.getParameter("mybirthyy")+"/"+request.getParameter("mybirthmm")+"/"+request.getParameter("mybirthdd");
    	  String myphone = request.getParameter("myphone");
    	  String myemail = request.getParameter("myemail");
    	  
    	  UserDto dto = new UserDto();
    	  
    	  dto.setUserbirthdate(mybirth);
    	  dto.setUserphone(myphone);
    	  dto.setUseremail(myemail);
    	  
    	  String res = dao.findid(dto);

    	  System.out.println(res);
    	  request.setAttribute("userid", res);
    	  
    	  if(res!=null&&res!="") {
              ServletContext context = getServletContext();
              RequestDispatcher dispatcher = context.getRequestDispatcher("/login_find_id.jsp");
              dispatcher.forward(request, response);
           }else {
              jsResponse("아이디 찾기 실패", "usercontroller?command=loginform", response);
           }
    	  
    	  
      }else if(command.equals("phonechk")) {
    	  String myphone = request.getParameter("myphone");
    	  String ran = "";
    	  
    	  ran=messageApp.sendsms(myphone);
    	  System.out.println(ran);
    	  
    	  if(ran!=""&&ran!=null) {
				response.sendRedirect("phonechk.jsp?ran="+ran);
				
			} else {
				response.sendRedirect("phonechk.jsp?ran="+ran);
			}
      }else if(command.equals("userlist_ajax")) {
			
			List<UserDto> userlist = dao.selectAll();
			
			JSONArray jarr = new JSONArray();
			
			for(int i =0 ; i <userlist.size();i++) {
				JSONObject tmp = new JSONObject();
				tmp.put("no", userlist.get(i).getUserno());
				tmp.put("id", userlist.get(i).getUserid());
				tmp.put("name", userlist.get(i).getUsername());
				tmp.put("email", userlist.get(i).getUseremail());
				tmp.put("role", userlist.get(i).getRole());
				tmp.put("enabled", userlist.get(i).getUserenabled());
				tmp.put("reg", userlist.get(i).getReg().toString());
				jarr.add(tmp);
			}
			response.setContentType("application/x-json; charset=utf-8");
			response.getWriter().print(jarr);
		}else if(command.equals("admin_userinfo")) {
			
			int userno = Integer.parseInt(request.getParameter("userno"));
			
			UserDto userDto = dao.selectOne(userno);			
			List<UsedDto> usedlist = usedDao.selectWriter(userDto.getUserid());
			
			request.setAttribute("userDto", userDto);
			if(usedlist != null) {
				request.setAttribute("usedlist", usedlist);
			}
			dispatch("admin_userinfo.jsp",request,response);
		}else if(command.equals("findpw")) {
			String mybirth = request.getParameter("mybirthyy")+"/"+request.getParameter("mybirthmm")+"/"+request.getParameter("mybirthdd");
	    	String myphone = request.getParameter("myphone");
	    	String myemail = request.getParameter("myemail");
	    	String myid = request.getParameter("myid"); 
	    	  
	    	UserDto dto = new UserDto();
	    	  
	    	dto.setUserbirthdate(mybirth);
	    	dto.setUserphone(myphone);
	    	dto.setUseremail(myemail);
	    	dto.setUserid(myid);
	    	  
	    	int res = dao.findpw(dto);

	    	System.out.println(res);
	    	request.setAttribute("userno", res);  
	    	
	    	if(res>0) {
	              ServletContext context = getServletContext();
	              RequestDispatcher dispatcher = context.getRequestDispatcher("/login_find_pw.jsp");
	              dispatcher.forward(request, response);
	        }else {
	            jsResponse("비번 찾기 실패", "usercontroller?command=loginform", response);
	        }
		}else if(command.equals("changepw")) {
			int myno = Integer.parseInt(request.getParameter("userno"));
			String mypw = request.getParameter("userpw");
			
			UserDto dto = new UserDto();
			
			dto.setUserno(myno);
			dto.setUserpw(mypw);
			
			int res = dao.changepw(dto);
			
			if(res>0) {
	            jsResponse("비밀 번호 변경 성공", "usercontroller?command=loginform", response);
	         }else {
	            jsResponse("비밀 번호 변경 실패", "usercontroller?command=registform", response);
	         }
			
		} else if(command.equals("multi_update")) {
			
			String[] usernolist = request.getParameterValues("chk");
			String[] rolelist = request.getParameterValues("role");
			String[] enabledlist = request.getParameterValues("enabled");
			if(usernolist == null || usernolist.length == 0){
				jsResponse("하나 이상 체크해주세요!", "MainController?command=adminpage&act=user", response);
			}else {
				
				List<UserDto> userlist = dao.selectAll();
				List<UserDto> updatelist = new ArrayList<UserDto>();
				
				for(int i = 0 ; i < userlist.size();i++) {
					for(int j = 0 ; j < usernolist.length;j++) {
						if(userlist.get(i).getUserno()==Integer.parseInt(usernolist[j])) {
							UserDto tmp = userlist.get(i);
							tmp.setRole(rolelist[i]);
							tmp.setUserenabled(enabledlist[i]);
							updatelist.add(tmp);
						}
					}
				}
				
				int res= dao.multiUpdate(updatelist);
				
				if(res>0) {
					jsResponse("변경되었습니다", "MainController?command=adminpage&act=user", response);
				}else {
					jsResponse("변경 중 오류가 발생하였습니다", "MainController?command=adminpage&act=user", response);
				}
			}
		}else if(command.equals("business")) {
			int userno = Integer.parseInt(request.getParameter("user_no"));
			
			UserDto dto = dao.selectOne(userno);
			
			request.setAttribute("dto", dto);
			
			RequestDispatcher dis = request.getRequestDispatcher("join_business.jsp");
			dis.forward(request, response);
		}else if(command.equals("join_biz")) {
			
			int userno = 0;
			String usernm = "";
			String biznm = "";
			String bizaddr = "";
			String bizcategory = "";
			String bizcontent = ""; //초기화
			
			String imgpath = ""; //이미지 경로 초기화
			String imgname = ""; //이미지 이름 초기화
			
			String uploadpath = request.getRealPath("download"); //upload파일에 실제 경로 설정
			
			System.out.println(uploadpath); //경로확인용
			
			try {
				MultipartRequest multi = new MultipartRequest(request, uploadpath,10*1024*1024,"UTF-8",new DefaultFileRenamePolicy());
				
				imgpath = multi.getFilesystemName("imgfile");				
				imgname = multi.getOriginalFileName("imgfile");
				
				userno = Integer.parseInt(multi.getParameter("userno"));
				usernm = multi.getParameter("usernm");
				biznm = multi.getParameter("biznm");
				bizaddr = multi.getParameter("bizaddr");
				
				if(multi.getParameter("health") != null) {
					if(bizcategory.length()==0) {bizcategory += multi.getParameter("health");
					}else {bizcategory += ","+multi.getParameter("health");}						
				}
				if(multi.getParameter("pilates") != null) {
					if(bizcategory.length()==0) {bizcategory += multi.getParameter("pilates");
					}else {bizcategory += ","+multi.getParameter("pilates");}						
				}
				if(multi.getParameter("yoga") != null) {
					if(bizcategory.length()==0) {bizcategory += multi.getParameter("yoga");
					}else {bizcategory += ","+multi.getParameter("yoga");}						
				}
				if(multi.getParameter("crossfit") != null) {
					if(bizcategory.length()==0) {bizcategory += multi.getParameter("crossfit");
					}else {bizcategory += ","+multi.getParameter("crossfit");}						
				}
				if(multi.getParameter("etc") != null) {
					if(bizcategory.length()==0) {bizcategory += multi.getParameter("etc");
					}else {bizcategory += ","+multi.getParameter("etc");}						
				}
			
				bizcontent = multi.getParameter("bizcontent");
				
				System.out.println(userno+usernm+biznm+bizaddr+bizcategory); //값 확인용 나중에 지워야함
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			if(imgname !=null && !imgname.equals("")) {
				BizDto dto = new BizDto();
				
				dto.setUserno(userno);
				dto.setUsernm(usernm);
				dto.setBiznm(biznm);
				dto.setBizaddr(bizaddr);
				dto.setBizcategory(bizcategory);
				dto.setBizcontent(bizcontent);
				dto.setBizpic(imgpath);
				
				int res = bdao.insert(dto);
				
				if(res>0) {
					response.sendRedirect("main.jsp");
				}else {
					response.sendRedirect("join_business.jsp");
				}
			}else {
				BizDto dto = new BizDto();
				
				dto.setUserno(userno);
				dto.setUsernm(usernm);
				dto.setBiznm(biznm);
				dto.setBizaddr(bizaddr);
				dto.setBizcategory(bizcategory);
				dto.setBizcontent(bizcontent);
				dto.setBizpic("");
				
				int res = bdao.insert(dto);
				
				if(res>0) {
					response.sendRedirect("main.jsp");
				}else {
					response.sendRedirect("join_business.jsp");
				}
			}
			
		}else if(command.equals("bizlist_ajax")) {
			
			List<BizDto> bizList = bdao.selectAll();
			
			JSONArray jarr = new JSONArray();
			
			for(int i =0 ; i <bizList.size();i++) {
				JSONObject tmp = new JSONObject();
				tmp.put("no", bizList.get(i).getBizno());
				tmp.put("writer", bizList.get(i).getUsernm());
				tmp.put("centernm", bizList.get(i).getBiznm());
				tmp.put("status", bizList.get(i).getBizstatus());
				tmp.put("reg", bizList.get(i).getBizreg().toString());
				jarr.add(tmp);
			}
			response.setContentType("application/x-json; charset=utf-8");
			response.getWriter().print(jarr);
		} else if(command.equals("bizdetail")) {
			
			int bizno = Integer.parseInt(request.getParameter("bizno"));
			
			BizDto bizDto = bdao.selectOne(bizno);
			
			request.setAttribute("bizDto", bizDto);
			dispatch("business_detail.jsp",request,response);
			
		} else if(command.equals("change_status")) {
			
			int bizno = Integer.parseInt(request.getParameter("bizno"));
			int userno = Integer.parseInt(request.getParameter("userno"));
			
			String status = request.getParameter("status");
			//승인수락 됬을때
			if(status.equals("Y")) {
				
				int res1 = bdao.statusUpdate(bizno, status);
				
				//등급 변경
				int res2 = dao.roleUpdate(userno, "BU");
				
				if(res1>0 && res2>0) {
					jsResponse("승인되었습니다","usercontroller?command=bizdetail&bizno="+bizno,response);
				} else {
					jsResponse("승인이 실패하었습니다","usercontroller?command=bizdetail&bizno="+bizno,response);
				}
				
			} 
			//승인 거절됬을때
			else if(status.equals("D")) {
				
				int res = bdao.statusUpdate(bizno, status);
				
				if(res>0) {
					jsResponse("거절되었습니다","usercontroller?command=bizdetail&bizno="+bizno,response);
				} else {
					jsResponse("승인거절이 실패하었습니다","usercontroller?command=bizdetail&bizno="+bizno,response);
				}
			}
		} else if(command.equals("biz_multi_delete")) {
			
			String[] biznoList = request.getParameterValues("chk");
			
			if(biznoList == null || biznoList.length==0) {
				jsResponse("하나 이상 체크해주세요!", "MainController?command=adminpage&act=biz", response);
			}else {
			int res = bdao.multiDelete(biznoList);
			
			if(res>0) {
				jsResponse("선택한 게시글(들)이 삭제되었습니다.","MainController?command=adminpage&act=biz",response);
			} else {
				jsResponse("선택한 게시글(들) 삭제 실패하였습니다.\n 다시 시도해주세요.","MainController?command=adminpage&act=biz",response);
			}
			}
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

