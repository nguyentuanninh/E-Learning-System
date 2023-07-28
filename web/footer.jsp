<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <p class="mb-4"><img src="${logo_footer.image}" alt="Image" class="img-fluid"></p>
            </div>
            <c:if test="${nav_footer != null}">
                <c:forEach items="${nav_footer}" var="nf">
                    <div class="col-md-3">
                        <h3 class="footer-heading">
                            <c:if test="${language=='vi_VN'}">
                                <span>${nf.name_vn}: </span>
                            </c:if>
                            <c:if test="${language!='vi_VN'}">
                                <span>${nf.name}: </span>
                            </c:if>
                        </h3>

                        <ul class="list-unstyled">
                            <c:forEach items="${nf.children}" var="nfc">
                                <li><a href="<c:if test="${nfc.href == null}">#</c:if><c:if test="${nfc.href != null}">${nfc.href}${nfc.slug}</c:if>">
                                        <c:if test="${language=='vi_VN'}">
                                            ${nfc.name_vn}
                                        </c:if>
                                        <c:if test="${language!='vi_VN'}">
                                            ${nfc.name}
                                        </c:if> ${nfc.content}</a></li>
                                    </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </c:if>
        </div>

    </div>
</div>