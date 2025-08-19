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

public class FrozenProductListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ProductListService prdService = new ProductListServiceImpl();
		int page = 1;
        int pageSize = 6;
        Integer maxPrice = null;
        
        int riceCnt = prdService.getTotalProductCount("냉동볶음밥");
        int fruitCnt = prdService.getTotalProductCount("냉동과일");
        int friedCnt = prdService.getTotalProductCount("튀김류");
        
        String category = req.getParameter("maincategory");
        
        String maxPriceParam = req.getParameter("maxPrice");
        if(maxPriceParam != null && !maxPriceParam.isEmpty()) {
            maxPrice = Integer.parseInt(maxPriceParam);
        }
        
        
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

        List<ProductVO> productList = prdService.getProductList(page, pageSize, sort, category, maxPrice);
        
        int totalProducts = prdService.getTotalProductCount(category);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        List<ProductVO> lowestFrozenProduct = prdService.getLowestPriceFrozenProducts();

        req.setAttribute("productList", productList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("sort", sort);
        req.setAttribute("currentCategory", category);
        req.setAttribute("riceCnt", riceCnt);
        req.setAttribute("fruitCnt", fruitCnt);
        req.setAttribute("friedCnt", friedCnt);
        req.setAttribute("lowestFrozenProduct", lowestFrozenProduct);
        
        

        req.getRequestDispatcher("product/frozenProductList.tiles").forward(req, resp);
        
    }
}
