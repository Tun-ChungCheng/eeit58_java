package ElectronicSignature;


import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.EmptyBorder;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.LinkedList;

public class Drawer extends JPanel implements ChangeListener {
    private LinkedList<Line> lines;
    private final LinkedList<Line> logs;
    private Color newFontColor;
    public JColorChooser tcc;

    public Drawer() {
        setBackground(Color.LIGHT_GRAY);
        setBorder(new EmptyBorder(10,10,10,10));

        tcc = new JColorChooser();
        tcc.getSelectionModel().addChangeListener(this);

        Listener listener = new Listener();
        addMouseListener(listener);
        addMouseMotionListener(listener);

        lines = new LinkedList<>();
        logs = new LinkedList<>();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;

        for (Line line: lines){
            g2d.setColor(line.getFontColor());

            for (int i = 1; i < line.getPoints().size(); i++){
                var position1 = line.getPoints().get(i - 1);
                var position2 = line.getPoints().get(i);

                double pointsDistance = Math.sqrt(Math.pow(position2.get("x") - position1.get("x"), 2)
                        + Math.pow(position2.get("y") - position1.get("y"), 2)) + 1;
                long interval = position2.get("time") - position1.get("time") + 1;
                float fontSize = (float) (interval / pointsDistance);

                if (fontSize > 15) fontSize = 15;
                if (fontSize < 5) fontSize = 5;

                BasicStroke bs = new BasicStroke(fontSize, BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND);
                g2d.setStroke(bs);
                g2d.drawLine(position1.get("x"), position1.get("y"), position2.get("x"), position2.get("y"));
            }
        }
    }

    public void clear(){
        lines.clear();

        repaint();
    }

    public void undo (){
        if (lines.isEmpty()) return;
        logs.add(lines.removeLast());

        repaint();
    }

    public void redo (){
        if (logs.isEmpty()) return;
        lines.add(logs.removeLast());

        repaint();
    }

    public void save(){
        BufferedImage paintImage = new BufferedImage(getWidth(), getHeight(), BufferedImage.TYPE_INT_RGB);

        Graphics2D g2d = paintImage.createGraphics();
        paint(g2d);

        String filePath = "Signature.jpg";
        File file = new File(filePath);

        try {
            ImageIO.write(paintImage, "jpeg", file);
            JOptionPane.showMessageDialog(null, "OK", "Confirm",JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void saveLines () {
        try ( ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("sign.lines")) )
        {
            oos.writeObject(lines);
            oos.flush();

            JOptionPane.showMessageDialog(null, "OK", "Confirm",JOptionPane.INFORMATION_MESSAGE);
        } catch (Exception e) {
            throw new RuntimeException();
        }
    }

    public void loadLines () {
        try ( ObjectInputStream ois = new ObjectInputStream(new FileInputStream("sign.lines")) )
        {
            lines = (LinkedList<Line>)ois.readObject();

            repaint();

            JOptionPane.showMessageDialog(null, "OK", "Confirm",JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException | ClassNotFoundException ex) {
                throw new RuntimeException(ex);
        }
    }

    @Override
    public void stateChanged(ChangeEvent e) {
        newFontColor = tcc.getColor();
    }

    private class Listener extends MouseAdapter {
        @Override
        public void mousePressed(MouseEvent e) {
            HashMap<String, Integer> point = new HashMap<>();

            point.put("x", e.getX());
            point.put("y", e.getY());
            point.put("time", (int)e.getWhen());

            Line line = new Line();

            line.getPoints().add(point);
            line.setFontColor(newFontColor);
            lines.add(line);

            repaint();
        }

        @Override
        public void mouseDragged(MouseEvent e) {
            HashMap<String, Integer> point = new HashMap<>();

            point.put("x", e.getX());
            point.put("y", e.getY());
            point.put("time", (int)e.getWhen());

            lines.getLast().getPoints().add(point);

            repaint();
        }
    }
}
