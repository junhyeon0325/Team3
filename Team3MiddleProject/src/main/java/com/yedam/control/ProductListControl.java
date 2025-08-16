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
        
        int vegetableCnt = prdService.getTotalProductCount("채소");
        int meatCnt = prdService.getTotalProductCount("정육");
        int fishCnt = prdService.getTotalProductCount("수산");
        
        String category = req.getParameter("maincategory");
        
        // page 파라미터가 있으면 파싱
        String pageParam = req.getParameter("page");
        if (pageParam != null)
        {
        	page = Integer.parseInt(pageParam);
        }
        
        String sort = req.getParameter("sort");
        if(sort == null || (!sort.equals("price") && !sort.equals("createdDate")))
        {
        	sort = "createdDate";
        }
        

        List<ProductVO> productList = prdService.getProductList(page, pageSize, sort, category);
        
        int totalProducts = prdService.getTotalProductCount(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        req.setAttribute("productList", productList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("sort", sort);
        req.setAttribute("currentCategory", category);
        req.setAttribute("vegetableCnt", vegetableCnt);
        req.setAttribute("meatCnt", meatCnt);
        req.setAttribute("fishCnt", fishCnt);

        req.getRequestDispatcher("product/productList.tiles").forward(req, resp);
        
    }
}


		
		
		
		

		//상품리스트
		/*ProductListService prd = new ProductListServiceImpl();
		List<ProductVO> productList = prd.getProductList();
		
		req.setAttribute("productList", productList);
		
		req.getRequestDispatcher("product/productList.tiles").forward(req, resp);
		*/
	

