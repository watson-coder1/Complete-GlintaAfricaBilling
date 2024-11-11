</div>
</div>
</div>

</div>
<button onclick="topFunction()" class="btn btn-danger btn-icon" id="back-to-top">
    <i class="ri-arrow-up-line"></i>
</button>
<!--end back-to-top-->

<!--preloader-->
{* <div id="preloader">
    <div id="status">
        <div class="spinner-border text-primary avatar-sm" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>
</div> *}
<script src="ui/ui/scripts/jquery.min.js"></script>
<script src="ui/ui/scripts/plugins/select2.min.js"></script>
<script src="ui/ui/scripts/pace.min.js"></script>
<script src="ui/ui/scripts/custom.js"></script>

<!-- JAVASCRIPT -->
<script src="ui/themes/invoika/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="ui/themes/invoika/assets/libs/simplebar/simplebar.min.js"></script>
<script src="ui/themes/invoika/assets/libs/node-waves/waves.min.js"></script>
<script src="ui/themes/invoika/assets/libs/feather-icons/feather.min.js"></script>
<script src="ui/themes/invoika/assets/js/plugins.js"></script>

<!-- apexcharts -->
<script src="ui/themes/invoika/assets/libs/apexcharts/apexcharts.min.js"></script>

<!-- Vector map-->
<script src="ui/themes/invoika/assets/libs/jsvectormap/js/jsvectormap.min.js"></script>
<script src="ui/themes/invoika/assets/libs/jsvectormap/maps/world-merc.js"></script>

<!-- Dashboard init -->
<script src="ui/themes/invoika/assets/js/pages/dashboard.init.js"></script>

<!-- App js -->
<script src="ui/themes/invoika/assets/js/app.js"></script>

{if isset($xfooter)}
    {$xfooter}
{/if}
{literal}
    <script>
        $(document).ready(function() {
            $('.select2').select2({theme: "bootstrap"});
            $('.select2tag').select2({theme: "bootstrap", tags: true});
            var listAtts = document.querySelectorAll(`button[type="submit"]`);
            listAtts.forEach(function(el) {
                if (el.addEventListener) { // all browsers except IE before version 9
                    el.addEventListener("click", function() {
                        $(this).html(
                            `<span class="glyphicon glyphicon-refresh" role="status" aria-hidden="true"></span>`
                        );
                        setTimeout(() => {
                            $(this).prop("disabled", true);
                        }, 100);
                    }, false);
                } else {
                    if (el.attachEvent) { // IE before version 9
                        el.attachEvent("click", function() {
                            $(this).html(
                                `<span class="glyphicon glyphicon-refresh" role="status" aria-hidden="true"></span>`
                            );
                            setTimeout(() => {
                                $(this).prop("disabled", true);
                            }, 100);
                        });
                    }
                }

            });
        });

        var listAtts = document.querySelectorAll(`[api-get-text]`);
        listAtts.forEach(function(el) {
            $.get(el.getAttribute('api-get-text'), function(data) {
                el.innerHTML = data;
            });
        });

        function setKolaps() {
            var kolaps = getCookie('kolaps');
            if (kolaps) {
                setCookie('kolaps', false, 30);
            } else {
                setCookie('kolaps', true, 30);
            }
            return true;
        }

        function setCookie(name, value, days) {
            var expires = "";
            if (days) {
                var date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        }

        function getCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }
    </script>
{/literal}

</body>

</html>