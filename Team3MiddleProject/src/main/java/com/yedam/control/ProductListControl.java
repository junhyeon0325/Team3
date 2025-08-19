package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.ProductListService;
import com.yedam.service.ProductListServiceImpl;
import com.yedam.vo.ProductVO;

public class ProductListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ProductListService prdService = new ProductListServiceImpl();
		int page = 1;
        int pageSize = 6;
        Integer maxPrice = null;
        int pageBlockSize = 5; // 페이지 버튼 몇 개씩 보여줄지
        
        int vegetableCnt = prdService.getTotalProductCount("채소");
        int meatCnt = prdService.getTotalProductCount("정육");
        int fishCnt = prdService.getTotalProductCount("수산");
        
        String category = req.getParameter("maincategory");
        
        String maxPriceParam = req.getParameter("maxPrice");
        if(maxPriceParam != null && !maxPriceParam.isEmpty()) {
            maxPrice = Integer.parseInt(maxPriceParam);
        }
        
        String sort = req.getParameter("sort");
        if(sort == null || (!sort.equals("price") && !sort.equals("createdDate")))
        {
        	sort = "createdDate";
        }
        
        // page 파라미터가 있으면 파싱
        String pageParam = req.getParameter("page");
        if (pageParam != null)
        {
        	page = Integer.parseInt(pageParam);
        }
        

		
        List<ProductVO> productList = prdService.getProductList(page, pageSize, sort, category, maxPrice);
        
        
        int totalProducts = prdService.getTotalProductCount(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        List<ProductVO> lowestProduct = prdService.getLowestPriceProducts();
        
        
     //  startPage, endPage 계산
        int currentBlock = (int)Math.ceil((double)page / pageBlockSize);
        int startPage = (currentBlock - 1) * pageBlockSize + 1;
        int endPage = Math.min(currentBlock * pageBlockSize, totalPages);
        
        
        req.setAttribute("productList", productList);
        req.setAttribute("vegetableCnt", vegetableCnt);
        req.setAttribute("meatCnt", meatCnt);
        req.setAttribute("fishCnt", fishCnt);
        req.setAttribute("lowestProduct", lowestProduct);
        req.setAttribute("sort", sort);
        req.setAttribute("maxPrice", maxPrice);
        
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("startPage", startPage);
        req.setAttribute("endPage", endPage);
        req.setAttribute("currentCategory", category);
        
        
        

        req.getRequestDispatcher("product/productList.tiles").forward(req, resp);
        
    }
}
