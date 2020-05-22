package relay.db;

public interface Sql {
	
	String getList = "select * from product";
	
	String getProduct = "select * from product where pid=?";
	
	String searchList = "select * from product where pname like ?" ;
	
	String searchProduct = "select * from product where pno=?";
	
	String insertProduct = "insert into product (pno, pid, pname, phprice, plprice, pmall, pmallurl, pimg, catid, tags) values (PNO.NEXTVAL,?,?,?,?,?,?,?,?,?)";
	
	String updateProduct = "update product set pname = ?, phprice = ?, plprice = ?, pmall = ?, pmallurl = ?, pimg = ? where pno = ?";
	
	String deleteProduct = "delete from product where pno = ?";
	
}
