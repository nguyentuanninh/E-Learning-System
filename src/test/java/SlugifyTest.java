
import org.junit.Assert;
import org.junit.Test;
import utilities.SlugifyUtil;


public class SlugifyTest {

    @Test
    public void testEnglishTitle() {
        //given
        int id = 1;
        String title = "Software Testing Tutorial";
        String expected = "software-testing-tutorial-1";

        //when
        String slug = SlugifyUtil.slugify(title, id);

        //then
        Assert.assertEquals(expected, slug);
    }

    @Test
    public void testVietnameseTitle() {
        //given
        int id = 1;
        String title = "Khóa học lập trình";
        String expected = "khoa-hoc-lap-trinh-1";

        //when
        String slug = SlugifyUtil.slugify(title, id);

        //then
        Assert.assertEquals(expected, slug);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testStringInputNullThrowsIllegalArgumentException() {
        SlugifyUtil.slugify(null, 1);
    }

    @Test
    public void testGetIdFromSlug() {
        //given
        String slug = "khoa-hoc-lap-trinh-1";
        int expected = 1;
        //when
        int id = SlugifyUtil.getIdFormSlug(slug);

        //then
        Assert.assertEquals(expected, id);
    }
}
