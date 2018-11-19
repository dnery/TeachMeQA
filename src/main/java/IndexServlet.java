import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*
            Do NOT set content type, headers, cookies or whatever...
            otherwise this will give an IllegalStateException

            resp.setContentType("text/html");
         */

        RequestDispatcher view = req.getRequestDispatcher("hello.jsp");

        view.forward(req, resp);
    }
}
