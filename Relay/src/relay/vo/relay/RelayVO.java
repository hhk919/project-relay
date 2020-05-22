package relay.vo.relay;

import java.util.List;

import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import relay.vo.member.Person;


@Document(collection="giftlist")
public class RelayVO {

	@Indexed(unique = true)
	@Field("listId")
	private String listId;
	@Field("recipient")
	private Person recipient;
	@Field("senders")
	private List<Sender> senders;

	@PersistenceConstructor
	public RelayVO(String listId, Person recipient, List<Sender> senders) {
		this.listId = listId;
		this.recipient = recipient;
		this.senders = senders;
	}

	public String getListId() {
		return listId;
	}

	public void setListId(String listId) {
		this.listId = listId;
	}

	public Person getRecipient() {
		return recipient;
	}

	public void setRecipient(Person recipient) {
		this.recipient = recipient;
	}

	public List<Sender> getSenders() {
		return senders;
	}

	public void setSenders(List<Sender> senders) {
		this.senders = senders;
	}


	
	
}
