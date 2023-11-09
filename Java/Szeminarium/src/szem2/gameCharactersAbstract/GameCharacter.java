package szem2.gameCharactersAbstract;

public abstract class GameCharacter {
    protected String name;
    protected int age;

    public GameCharacter(String name, int age){
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "name= " + name + "   age=" + age;
    }

    public abstract void executeSkill();
}
