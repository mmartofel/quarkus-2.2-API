package pl.gov;

import java.util.List;

import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

@Path("/person")
public class PersonAPI {

@Path("list")
@GET
@Produces(MediaType.APPLICATION_JSON)
public List<Person> all() {
    System.out.println("List all persons API call");
 return Person.listAll();
}

@Path("add")
@Transactional
@POST
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public Response newPerson(Person person) {
    person.id = null;
    person.persist();
    return Response.status(Status.CREATED).entity(person).build();
}

@Path("count")
@GET
@Produces(MediaType.APPLICATION_JSON)
public long count() {
    return Person.count();
}

}
