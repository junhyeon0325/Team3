package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.SaleProductService;
import com.yedam.service.SaleProductServiceImpl;
import com.yedam.vo.ProductVO;

public class SaleProductControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SaleProductService spd = new SaleProductServiceImpl();
		
		int page = 1;
		int pageSize = 6;
		int totalSaleProduct = spd.countTotalSaleProducts();
		int totalSalePage = (int)Math.ceil((double)totalSaleProduct/pageSize);
		int pageBlockSize = 5; // 페이지 버튼 몇개씩 보여줄지
							   // pageBlockSize를 Control에 만들어서 여러 JSP 한번에 관리도 가능 단점으로는 하나의 jsp만 변경하기는 어렵지만 보통 페이징은 동일하게 설정해서 괜춘
        
		Integer maxPrice = null;
		
		String maxPriceParam = req.getParameter("maxPrice");
        if(maxPriceParam != null && !maxPriceParam.isEmpty()) {
            maxPrice = Integer.parseInt(maxPriceParam);
        }
		
		
        String sort = req.getParameter("sort");
        if(sort == null || (!sort.equals("price") && !sort.equals("createdDate")))
        {
        	sort = "createdDate";
        }
		
        String pageParam = req.getParameter("page");
        if (pageParam != null)
        {
        	page = Integer.parseInt(pageParam);
        }
		
        List<ProductVO> saleList = spd.selectSaleProductList(page, pageSize, sort, maxPrice);
        
        // startPage, endPage 계산
        int currentBlock = (int)Math.ceil((double) page / pageBlockSize);
        int startPage = (currentBlock -1) * pageBlockSize +1;
        int endPage = Math.min(currentBlock * pageBlockSize, totalSalePage);

        
		req.setAttribute("saleList", saleList);
		req.setAttribute("currentPage", page);
		req.setAttribute("totalSalePage", totalSalePage);
	    req.setAttribute("startPage", startPage);
	    req.setAttribute("endPage", endPage);
		
	    req.setAttribute("sort", sort);
	    req.setAttribute("maxPrice", maxPrice);
	    
	    req.setAttribute("totalSalePage", totalSalePage);
	    req.setAttribute("pageBlockSize", pageBlockSize);
		
		req.getRequestDispatcher("product/saleProduct.tiles").forward(req, resp);
	}

}
