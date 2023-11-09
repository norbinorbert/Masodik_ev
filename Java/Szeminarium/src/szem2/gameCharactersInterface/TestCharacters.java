package szem2.gameCharactersInterface;

public class TestCharacters {
    public static void main(String[] args) {
//    IGameCharacter a = new IGameCharacter() {
//        @Override
//        public void executeSkill() {
//
//        }
//    }
        IGameCharacter a = new Druid("Feraldream", 80, "Cat Form");
        System.out.println(a);
        a.executeSkill();
    }
}