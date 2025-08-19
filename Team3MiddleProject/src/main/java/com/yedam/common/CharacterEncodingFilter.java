package com.yedam.common;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
// 모든 .do 요청과 .tiles 요청에 대해 필터를 적용합니다.
@WebFilter("/*") // 모든 요청에 적용 (필요에 따라 "*.do" 등으로 제한 가능)
public class CharacterEncodingFilter extends HttpFilter implements Filter {
   private String encoding;
   public void init(FilterConfig fConfig) throws ServletException {
       this.encoding = fConfig.getInitParameter("encoding");
       if (this.encoding == null) {
           this.encoding = "UTF-8"; // 기본 인코딩
       }
   }
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
           throws IOException, ServletException {
       // 요청과 응답의 캐릭터 인코딩을 UTF-8로 설정합니다.
       request.setCharacterEncoding(encoding);
       response.setCharacterEncoding(encoding);
       response.setContentType("text/html; charset=" + encoding); // 응답 타입도 명시적으로 설정
       // 다음 필터 또는 서블릿으로 요청을 전달합니다.
       chain.doFilter(request, response);
   }
   public void destroy() {
       // 필터 종료 시 리소스 해제 (필요시)
   }
}

