/*!
 * Bootstrap Table of Contents v0.1.0 (http://afeld.github.io/bootstrap-toc/)
 * Copyright 2015 Aidan Feldman
 * Licensed under MIT (https://github.com/afeld/bootstrap-toc/blob/gh-pages/LICENSE.md) */
! function() {
    "use strict";
    window.Toc = {
        helpers: {
            generateUniqueIdBase: function(e) {
                var t = $(e).text(),
                    n = t.trim().toLowerCase().replace(/[^A-Za-z0-9]+/g, "-");
                return n || e.tagName.toLowerCase()
            },
            generateUniqueId: function(e) {
                for (var t = this.generateUniqueIdBase(e), n = 0;; n++) {
                    var r = t;
                    if (n > 0 && (r += "-" + n), !document.getElementById(r)) return r
                }
            },
            generateAnchor: function(e) {
                if (e.id) return e.id;
                var t = this.generateUniqueId(e);
                return e.id = t, t
            },
            createNavList: function() {
                return $('<ul class="nav"></ul>')
            },
            createChildNavList: function(e) {
                var t = this.createNavList();
                return e.append(t), t

            },
            generateNavItem: function(e) {
                var t = this.generateAnchor(e),
                    n = $(e).text();
                return $('<li><a href="#' + t + '">' + n + "</a></li>");

            },
            getTopLevel: function(e) {
                for (var t, n = 1; 4 > n; n++) {
                    var r = e.find("h" + n);
                    if (r.length > 1) {
                        t = n;
                        break
                    }
                }

                return t || 1;
            },
            getHeadings: function(e, t) {
                var n = "h" + t,
                    r = t + 1,
                    a = "h" + r;
                return e.find(n + "," + a)
            },
            getNavLevel: function(e) {
                return parseInt(e.tagName.charAt(1), 10)
            },
            populateNav: function(e, t, n) {
                var r, a = e,
                    i = this;

                n.each(function(n, o) {
                  // console.log(n);
                  if (n > 4) {
                    var s = i.generateNavItem(o),
                        u = i.getNavLevel(o);
                    u === t ? a = e : r && a === e && (a = i.createChildNavList(r)), a.append(s), r = s
                  }
                })
            },
            parseOps: function(e) {
                var t;
                return t = e.jquery ? {
                    $nav: e
                } : e, t.$scope = t.$scope || $(document.body), t
            }
        },
        init: function(e) {
            e = this.helpers.parseOps(e);
            var t = this.helpers.createChildNavList(e.$nav),
                n = this.helpers.getTopLevel(e.$scope),
                r = this.helpers.getHeadings(e.$scope, n);
            this.helpers.populateNav(t, n, r)

        }
    }, $(function() {
        $('nav[data-toggle="toc"]').each(function(e, t) {
            var n = $(t);
            Toc.init(n);

        })
    })
}();
