package Thread;

public class TimerControl implements Runnable{
    private TimerModel model;
    private TimerView view;

    public TimerControl(TimerModel model, TimerView view){
        this.model = model;
        this.view = view;
    }

    //ez hivodik meg amikor elinditjuk a szalat
    @Override
    public void run() {
        int start;
        do{
            start = model.getStart();
            model.setStart(start + 1);
            try {
                Thread.sleep(1000);
            }
            catch (InterruptedException e){
                System.out.println("Hiba");
            }
            view.repaint();
        }while(start < model.getEnd());
    }

}
