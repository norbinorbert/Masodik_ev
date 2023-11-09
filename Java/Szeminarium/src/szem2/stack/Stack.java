package szem2.stack;

public class Stack {
    private Node top;

    public Stack(){
        top = null;
    }

    public void push(int info){
        top = new Node(info, top);
    }
    public int pop(){
        try {
            int info = top.getInfo();
            top = top.getNext();
            return info;
        }
        catch (NullPointerException e){
            System.out.println("Stack empty");
            return 0;
        }
    }

    public void print(){
        Node temp = top;
        while(temp != null){
            System.out.print(temp.getInfo() + " ");
            temp = temp.getNext();
        }
        System.out.println();
    }
}
