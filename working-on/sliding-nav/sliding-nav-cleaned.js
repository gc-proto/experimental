(function ($, wb) {
  "use strict";

  var componentName = "gc-nav",
      selector = "." + componentName,
      initEvent = "wb-init" + selector,
      $document = wb.doc,
      selectorAjaxed = selector + " [data-ajax-after]",
      globalTimeoutOn,
      globalTimeoutOff,
      hoverDelay = 350,
      justOpened,
      isMobileMode,
      isMediumView,
      preventFocusIn,
      i18nInstruction = {
        en: "Press the SPACEBAR to expand or the escape key to collapse this menu. Use the Up and Down arrow keys to choose a submenu item. Press the Enter or Right arrow key to expand it, or the Left arrow or Escape key to collapse it. Use the Up and Down arrow keys to choose an item on that level and the Enter key to access it.",
        fr: "Appuyez sur la barre d'espacement pour ouvrir ou sur la touche d'échappement pour fermer le menu. Utilisez les flèches haut et bas pour choisir un élément de sous-menu. Appuyez sur la touche Entrée ou sur la flèche vers la droite pour le développer, ou sur la flèche vers la gauche ou la touche Échap pour le réduire. Utilisez les flèches haut et bas pour choisir un élément de ce niveau et la touche Entrée pour y accéder."
      },

    init = function (event) {
      var elm = wb.init(event, componentName, selector),
          ajaxFetch;
      if (elm) {
        if (i18nInstruction[wb.lang]) {
          i18nInstruction = i18nInstruction[wb.lang];
        } else if (i18nInstruction.en) {
          i18nInstruction = i18nInstruction.en;
        }

        ajaxFetch = elm.querySelector(selectorAjaxed);

        if (!ajaxFetch) {
          onAjaxLoaded(elm.querySelector("[role=menu]"));
        }

      }
    },
    onAjaxLoaded = function (subElm) {
      var $elm = $(subElm).parentsUntil(selector).parents(),
          htmlClassName = document.querySelector("html").className;

      isMobileMode = htmlClassName.indexOf("smallview") !== -1;
      isMediumView = htmlClassName.indexOf("mediumview") !== -1;

      if (isMobileMode || isMediumView) {
        setMnu3LevelOrientationExpandState(false, isMediumView);
      }

      wb.ready($elm, componentName);
    };

  function OpenMenu(elm) {

    if (elm.getAttribute("aria-expanded") === "true") {
      return;
    }

    var parentMenu = elm.parentElement.parentElement;

    var menuOpen = parentMenu.querySelector("[aria-haspopup][aria-expanded=true]:not([data-keep-expanded=md-min])");

    if (menuOpen && !isMobileMode) {
      CloseMenu(menuOpen, true);
    }

    elm.setAttribute("aria-expanded", "true");

    justOpened = elm;
    setTimeout(function () {
      justOpened = false;
    }, hoverDelay);

  }
  function CloseMenu(elm, force) {

    if (!elm) {
      return;
    }

    if (!elm.hasAttribute("aria-haspopup")) {
      elm = elm.previousElementSibling;
    }

    if (!force) {

      var currentFocusIsOn = elm.nextElementSibling.querySelector("[role=menu]:focus");
      var siblingHasFocus = elm.parentElement.parentElement.querySelector("[role=menu]:focus");

      if (currentFocusIsOn || siblingHasFocus === elm) {
        return;
      }
    }

    elm.setAttribute("aria-expanded", "false");

  }

  function OpenMenuWithDelay(elm) {

    if (elm.dataset.keepExpanded === "md-min") {
      return;
    }

    clearTimeout(globalTimeoutOn);

    globalTimeoutOn = setTimeout(function () {
      OpenMenu(elm);
    }, hoverDelay);
  }

  $document.on("mouseenter", selector + " ul [aria-haspopup]", function (event) {

    if (!isMobileMode) {
      clearTimeout(globalTimeoutOff);
      OpenMenuWithDelay(event.currentTarget);
    }
  });

  $document.on("focusin", selector + " ul [aria-haspopup]", function (event) {

    if (isMobileMode) {
      preventFocusIn = false;
      return;
    }

    OpenMenu(event.currentTarget);

  });

  $document.on("mouseenter focusin", selector + " [aria-haspopup] + [role=menu]", function (event) {

    var elm = event.currentTarget.previousElementSibling;

    if (elm.dataset.keepExpanded === "md-min") {
      return;
    }

    if (isMobileMode || justOpened === event.currentTarget) {
      return;
    }

    clearTimeout(globalTimeoutOff);
  });

  $document.on("mouseleave", selector + " [aria-haspopup]", function () {
    clearTimeout(globalTimeoutOn);
  });

  $document.on("click", selector + " [aria-haspopup]", function (event) {
    event.stopImmediatePropagation();
    event.preventDefault();

    var elm = event.currentTarget,
      elmToGiveFocus;

    if (preventFocusIn) {
      preventFocusIn = false;
      return;
    }

    if (isMobileMode || elm.nodeName === "BUTTON") {

      if (elm.getAttribute("aria-expanded") === "true") {
        if (justOpened !== elm) {
          CloseMenu(elm, true);
        }
      } else {
        OpenMenu(elm);

        elmToGiveFocus = elm.nextElementSibling.querySelector("[role=menu]");
        elmToGiveFocus.focus();
        elmToGiveFocus.setAttribute("tabindex", "0");

      }
    }

  });

  function setMnu3LevelOrientationExpandState(isVertical, isExpanded) {
    var mnu3Level = document.querySelectorAll("[role=menu] [role=menu] [role=menuitem][aria-haspopup=true]"),
      i, i_len = mnu3Level.length,
      expandState = (isExpanded ? "true" : "false"),
      orientation = (isVertical ? "vertical" : "horizontal"),
      expandStateItem = expandState;

    for (i = 0; i < i_len; i++) {

      expandStateItem = (mnu3Level[i].nextElementSibling.querySelector("[role=menuitem]:focus") ? "true" : expandState);

      mnu3Level[i].setAttribute("aria-expanded", expandStateItem);
      mnu3Level[i].parentElement.previousElementSibling.setAttribute("aria-orientation", orientation);
    }
  }

  $document.on(wb.resizeEvents, function (event) {

    switch (event.type) {
      case "xxsmallview":
      case "xsmallview":
      case "smallview":
        isMobileMode = true;
        setMnu3LevelOrientationExpandState(false, false);
        break;
      case "mediumview":
        isMobileMode = false;
        setMnu3LevelOrientationExpandState(false, true);
        break;
      case "largeview":
      case "xlargeview":
      default:
        isMobileMode = false;
        setMnu3LevelOrientationExpandState(true, true);
    }
  });


  function keycode(code) {

    if (code === 9) {
      return "tab";
    }

    if (code === 13 || code === 32) {
      return "enter";
    }
    if (code === 27) {
      return "esc";
    }
    if (code === 39) {
      return "right";
    }
    if (code === 37) {
      return "left";
    }
    if (code === 40) {
      return "down";
    }
    if (code === 38) {
      return "up";
    }

    return false;
  }

  $document.on("keydown", function (event) {
    if (event.keyCode === 27) {
      CloseMenu(document.querySelector(selector + " button"));
    }
  });

  $document.on("keydown", selector + " button, " + selector + " [role=menuitem]", function (event) {

    var elm = event.currentTarget,
      key = keycode(event.charCode || event.keyCode);

    var currentFocusIsOn = document.querySelector("[role=menuitem]:focus") || elm,
      parent = currentFocusIsOn.parentElement,
      grandParent = parent.parentElement,
      isCurrentButtonMenu = (currentFocusIsOn.nodeName === "BUTTON");

    if (key === "tab") {
      CloseMenu(document.querySelector(selector + " button"), true);
      return;
    }

    if (isCurrentButtonMenu && key === "enter" && elm.getAttribute("aria-expanded") === "true") {
      preventFocusIn = true;
      CloseMenu(elm, true);
      return;
    }

    var firstChildPopup;
    if (currentFocusIsOn.nextElementSibling) {
      firstChildPopup = currentFocusIsOn.nextElementSibling.querySelector("[role='menuitem']");
    }

    var nextSiblingMenuItem;
    if (parent.nextElementSibling) {
      nextSiblingMenuItem = parent.nextElementSibling.querySelector("[role=menuitem]");

      if (!nextSiblingMenuItem) {
        nextSiblingMenuItem = parent.nextElementSibling.nextElementSibling.querySelector("[role=menuitem]");
      }
    } else {

      if (!isMobileMode && currentFocusIsOn.dataset.keepExpanded && firstChildPopup) {

        nextSiblingMenuItem = firstChildPopup;
      } else if (!isMobileMode && grandParent.previousElementSibling.dataset.keepExpanded) {

        nextSiblingMenuItem = grandParent.parentElement.parentElement.querySelector("[role=menuitem]");
      } else {
        nextSiblingMenuItem = grandParent.querySelector("[role=menuitem]");
      }
    }

    var parentPopupBtn = grandParent.previousElementSibling;

    var previousSiblingMenuItem;
    if (parent.previousElementSibling) {
      previousSiblingMenuItem = parent.previousElementSibling.querySelector("[role=menuitem]");

      if (!previousSiblingMenuItem) {
        previousSiblingMenuItem = parent.previousElementSibling.previousElementSibling.querySelector("[role=menuitem]");
      }
    } else {

      if (!isMobileMode && grandParent.lastElementChild.querySelector("[role=menuitem]").dataset.keepExpanded) {

        previousSiblingMenuItem = grandParent.lastElementChild.querySelector("[role=menuitem]").nextElementSibling.lastElementChild.querySelector("[role=menuitem]");
      } else if (!isMobileMode && grandParent.previousElementSibling.dataset.keepExpanded && parentPopupBtn) {

        previousSiblingMenuItem = parentPopupBtn;
      } else if (isCurrentButtonMenu) {

        previousSiblingMenuItem = currentFocusIsOn.nextElementSibling.lastElementChild.querySelector("[role=menuitem]");
      } else {

        previousSiblingMenuItem = grandParent.lastElementChild.querySelector("[role=menuitem]");
      }

    }

    var isNextSeparatorOrientationVertical,
      nextSeparatorMenuItem,
      iteratedItem = parent;
    while (iteratedItem.nextElementSibling) {
      iteratedItem = iteratedItem.nextElementSibling;
      if (iteratedItem.getAttribute("role") === "separator") {
        if (iteratedItem.hasAttribute("aria-orientation") && iteratedItem.getAttribute("aria-orientation") === "vertical") {
          isNextSeparatorOrientationVertical = true;
        } else {
          isNextSeparatorOrientationVertical = false;
        }
        nextSeparatorMenuItem = iteratedItem.nextElementSibling.querySelector("[role=menuitem]");
        break;
      }
    }

    var isPreviousSeparatorOrientationVertical,
      previousSeparatorMenuItem;
    iteratedItem = parent;
    while (iteratedItem.previousElementSibling) {
      iteratedItem = iteratedItem.previousElementSibling;
      if (iteratedItem.getAttribute("role") === "separator") {
        if (previousSeparatorMenuItem) {
          break;
        }
        if (iteratedItem.hasAttribute("aria-orientation") && iteratedItem.getAttribute("aria-orientation") === "vertical") {
          isPreviousSeparatorOrientationVertical = true;
        } else {
          isPreviousSeparatorOrientationVertical = false;
        }
        previousSeparatorMenuItem = iteratedItem.previousElementSibling;
      }
      if (previousSeparatorMenuItem) {
        previousSeparatorMenuItem = iteratedItem;
      }
    }

    if (previousSeparatorMenuItem) {
      previousSeparatorMenuItem = previousSeparatorMenuItem.querySelector("[role=menuitem]");
    }

    if (!isCurrentButtonMenu) {
      currentFocusIsOn.setAttribute("tabindex", "-1");
    }

    var elmToGiveFocus;
    if (key === "down" && nextSiblingMenuItem) {
      elmToGiveFocus = nextSiblingMenuItem;
    } else if (key === "up" && previousSiblingMenuItem) {
      elmToGiveFocus = previousSiblingMenuItem;
    } else if ((!isCurrentButtonMenu && key === "right" && firstChildPopup) || key === "enter" && firstChildPopup) {
      elmToGiveFocus = firstChildPopup;
    } else if (isNextSeparatorOrientationVertical && key === "right") {
      elmToGiveFocus = nextSeparatorMenuItem;
    } else if (isPreviousSeparatorOrientationVertical && key === "left") {
      elmToGiveFocus = previousSeparatorMenuItem;
    } else if ((!isCurrentButtonMenu && key === "left") || (!isCurrentButtonMenu && key === "esc")) {
      elmToGiveFocus = parentPopupBtn;
    } else if (key === "tab") {
      return;
    }

    if (key === "left" || key === "esc") {

      if (!isCurrentButtonMenu && isMobileMode && elmToGiveFocus.getAttribute("aria-expanded") === "true") {
        elmToGiveFocus.setAttribute("aria-expanded", "false");
      } else if (isCurrentButtonMenu) {
        elm.setAttribute("aria-expanded", "false");
      }
    }

    if (elmToGiveFocus) {

      if (isMobileMode || isCurrentButtonMenu) {
        var popup = elmToGiveFocus.parentElement.parentElement.previousElementSibling;
        if (popup.getAttribute("aria-expanded") !== "true") {

          OpenMenu(popup);
        }
      }

      elmToGiveFocus.setAttribute("tabindex", "0");
      elmToGiveFocus.focus();

      event.stopImmediatePropagation();
      event.preventDefault();
    }

  });

  $document.on("ajax-fetched.wb ajax-failed.wb", selectorAjaxed, function (event) {

    var elm = event.target;

    if (event.currentTarget === elm) {
      onAjaxLoaded(elm);
    }
  });

  $document.on("timerpoke.wb " + initEvent, selector, init);

  wb.add(selector);

})(jQuery, wb);
