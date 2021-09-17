package pl.gov;

import javax.persistence.Column;
import javax.persistence.Entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
public class Person extends PanacheEntity{

    @Column(length = 20)
    public String name;

    @Column(length = 50)
    public String surname;

    @Column(length = 11)
    public String pesel;
    
}
