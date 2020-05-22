package relay.dao.product;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import relay.common.APISearch;
import relay.db.*;
import relay.vo.product.ProductVO;
import relay.vo.product.ShoppingCondition;

@Repository
public class ProductDAO implements Sql, SqlMethod  {

	public ArrayList<JSONObject> searchList(ShoppingCondition sc) {

		ArrayList<JSONObject> list = APISearch.searchList(sc);
		
		return list;
	}
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public class UserRowMapper implements RowMapper<ProductVO> {

		@Override
		public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ProductVO prd = new ProductVO();
			prd.setPno(rs.getLong("pno"));
			prd.setPname(rs.getString("pname"));
			prd.setPhprice(rs.getInt("phprice"));
			prd.setPlprice(rs.getInt("plprice"));
			prd.setPmall(rs.getString("pmall"));
			prd.setPmallurl(rs.getString("pmallurl"));
			prd.setPimg(rs.getString("pimg"));
			prd.setPid(rs.getLong("pid"));
			return prd;
		}
		
	}
		
	@Override
	public List<ProductVO> getListForAdmin() {
		
		RowMapper<ProductVO> rowMapper = new UserRowMapper();
		
		return jdbcTemplate.query(getList, rowMapper);
			
	}
	

	@Override
	public List<ProductVO> searchListForAdmin(String pname) {
		
		RowMapper<ProductVO> rowMapper = new UserRowMapper();
		
		return jdbcTemplate.query(searchList, rowMapper, new Object[] {pname});
		
	}

	@Override
	public int insertProductForAdmin(ProductVO prd) {

		Object[] obj = new Object[] {prd.getPid(), prd.getPname(), prd.getPhprice(), prd.getPlprice(), prd.getPmall(), prd.getPmallurl(), prd.getPimg(), prd.getCatid(), prd.getTags()};
		
		return jdbcTemplate.update(insertProduct, obj);
	}
	
	public int insertProduct(ProductVO prd) {
		
		Object[] obj = new Object[] {prd.getPid(), prd.getPname(), prd.getPhprice(), prd.getPlprice(), prd.getPmall(), prd.getPmallurl(), prd.getPimg(), prd.getCatid(), prd.getTags()};
		return jdbcTemplate.update(insertProduct, obj);
	}

	@Override
	public int updateProductForAdmin(ProductVO prd) {

		Object[] obj = new Object[] {prd.getPname(), prd.getPhprice(), prd.getPlprice(), prd.getPmall(), prd.getPmallurl(), prd.getPimg(), prd.getPno()};
		
		return jdbcTemplate.update(updateProduct, obj);
	}

	@Override
	public int deleteProductForAdmin(int pno) {

		return jdbcTemplate.update(deleteProduct, new Object[] {pno});
	}

	@Override
	public ProductVO searchProductForAdmin(int update_no) {		
	
		RowMapper<ProductVO> rowMapper = new UserRowMapper();
		ProductVO vo= (ProductVO) jdbcTemplate.queryForObject(searchProduct, rowMapper, new Object[] {update_no});
		return vo;
	}


	public ProductVO getProduct(Long pid) {
		RowMapper<ProductVO> rowMapper = new UserRowMapper();
		ProductVO prd = null;
		try {
			//product table 상품 확인
			prd = jdbcTemplate.queryForObject(getProduct, rowMapper, new Object[] {pid});
			//상품이 있는 경우
			return prd;
		}catch(Exception e) {
			//product table에 상품이 없는 경우
			return null;
		}
	}

}
