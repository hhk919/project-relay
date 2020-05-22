package relay.db;

import java.util.List;

import relay.vo.product.ProductVO;

public interface SqlMethod {
	
	//"select * from product"
	public List<ProductVO> getListForAdmin();
	
	//"select * from product where pname like ?" 
	public List<ProductVO> searchListForAdmin(String pname);
	
	//"select * from product where pno=?"
	public ProductVO searchProductForAdmin(int pno);
	
	//"insert into product values (?,?,?,?,?,?)";
	public int insertProductForAdmin(ProductVO prd);
	
	//"update product set pname = ?, phprice = ?, plprice = ?, pmal = ?, pimg = ? where pno = ?
	public int updateProductForAdmin(ProductVO prd);

	//"delete from product where pno = ?"
	public int deleteProductForAdmin(int pno);
}
