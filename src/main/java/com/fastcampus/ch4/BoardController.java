package com.fastcampus.ch4;

import com.fastcampus.ch4.domain.*;
import com.fastcampus.ch4.service.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.*;

import javax.servlet.http.*;
import java.time.*;
import java.util.*;

@Controller
@RequestMapping("/board")
//weser
public class BoardController {
    @Autowired
    BoardService boardService;
    @PostMapping
    public String write(BoardDto boardDto, Model m, HttpSession session, RedirectAttributes rattr){
        String writer = (String) session.getAttribute("id");
        boardDto.setWriter(writer);

        try {
            int rowCnt = boardService.write(boardDto);

            if(rowCnt !=1)
                throw new Exception("Write failed");
            rattr.addFlashAttribute("MSG","WRT_OK");

            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute(boardDto);
            m.addAttribute("msg","WRT_ERR");
            return "board";
        }

    }
@GetMapping("/write")
    public String write(Model m){
    m.addAttribute("mode","new");
    return "board";
    }
    @PostMapping("/remove")
    public String remove (Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr){
     String writer = (String) session.getAttribute("id");
        try {
            m.addAttribute("page",page);
            m.addAttribute("pageSize",pageSize);

            int rowCnt = boardService.remove(bno, writer);

            if (rowCnt != 1)
                throw new Exception("board remove error");

            rattr.addFlashAttribute("msg","DELETE_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg","DELETE_ERR");
        }

        return "redirect:/board/list";
    }
    @GetMapping("/read")
    public String read(Integer bno,Integer page, Integer pageSize, Model m){
        try {
            BoardDto boardDto = boardService.read(bno);
            m.addAttribute(boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
           e.printStackTrace();
        }
        return "board";
    }

    @GetMapping("/list")
    public String list(Integer page, Integer pageSize, Model m,HttpServletRequest request) {
        if(!loginCheck(request))
            return "redirect:/login/login?toURL="+request.getRequestURL();  // ???????????? ???????????? ????????? ???????????? ??????

        if(page == null) page = 1;
        if(pageSize == null) pageSize = 10;

        try {

            int totalCnt = boardService.getCount();
            PageHandler pageHandler = new PageHandler(totalCnt, page, pageSize);

            Map map = new HashMap();
            map.put("offset",(page-1)*pageSize);
            map.put("pageSize", pageSize);
            List<BoardDto> list = boardService.getPage(map);
            m.addAttribute("list", list);
            m.addAttribute("ph",pageHandler);
            m.addAttribute("page",page);
            m.addAttribute("pageSize",pageSize);

        } catch (Exception e) {
          e.printStackTrace();
        }
        return "boardList"; // ???????????? ??? ????????????, ????????? ???????????? ??????
    }

    private boolean loginCheck(HttpServletRequest request) {
        // 1. ????????? ?????????
        HttpSession session = request.getSession();
        // 2. ????????? id??? ????????? ??????, ????????? true??? ??????
        return session.getAttribute("id")!=null;
    }
}