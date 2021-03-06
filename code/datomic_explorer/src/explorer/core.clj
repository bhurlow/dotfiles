(ns explorer.core
  (:require [datomic.client.api :as d]
            [cljfx.ext.tab-pane :as fx.ext.tab-pane]
            [cljfx.api :as fx]))

(+ 123 123)

(def cfg
  {:server-type :peer-server
   :access-key "foo"
   :secret "bar"
   ; :endpoint (System/getenv "DATOMIC_PEER_SERVER_URL")
   :endpoint "0.0.0.0:8080"
   :validate-hostnames false})


(def client
  (d/client cfg))


(defonce conn
  (d/connect client {:db-name "yellowdig"}))


; (defonce aux-conn
;   (d/connect client {:db-name "aux"}))

(defn now []
  (d/db conn))

;; ===== ui

(def *state
  (atom {:gravity 10
         :friction 0.4}))


(defn- with-tab-selection-props [props desc]
  {:fx/type fx.ext.tab-pane/with-selection-props
   :props props
   :desc desc})

(defn list-view []
  {:fx/type :list-view
   :items ["yo " "bar"]
   :cell-factory {:fx/cell-type :list-cell
                  :describe (fn [path] {:text path})}})

(comment
  (d/pull 
    (now)
    17592186045419))

    
(defn result-list [{:keys [state]}]
  {:fx/type :list-view
   :items (or (some-> state :result keys) [])
   :cell-factory 
   {:fx/cell-type :list-cell
    :describe (fn [path] {:text (str path)})}})

(defn result-table [{:keys [state]}]
  {:fx/type :table-view
   :items (or (some-> (:result @*state) seq) 
              [[:key :val]
               [:k2 :val2]])
   ; :items [:foo :bar1]
   :columns [{:fx/type :table-column
              :text "pr-str"
              :cell-value-factory identity
              :cell-factory {:fx/cell-type :table-cell
                             :describe (fn [x] {:text (pr-str (first x))})}}

             {:fx/type :table-column
              :text "pr-str"
              :cell-value-factory identity
              :cell-factory {:fx/cell-type :table-cell
                             :describe (fn [x] {:text (pr-str (second x))})}}]})

(defn default-eid []
  (:db/id
    (d/pull (now)
            '[*]
             [:user/username "prof"])))

(defn pull-view [state]
  {:fx/type :v-box
   :children [{:fx/type :label
               :text "yo"}
              {:fx/type :h-box
               :children [{:fx/type :text-field
                           :on-text-changed {:event/type ::yolo}
                           :max-width 400
                           :text (str (default-eid))}
                          {:fx/type :button
                           :text "go"
                           :on-action {:event/type ::fetch-entity}}
                          {:fx/type :label
                           :text "other item"}]}
              {:fx/type result-table
               :state state}]})

(def tabs
  {:pull pull-view})

(defn tab-pane [{:keys [items state]}]
  (with-tab-selection-props
    {}
    {:fx/type :tab-pane
     :min-width 960
     :tabs
     (->> items
          (map (fn [item]
                 {:fx/type :tab
                  ; :state state
                  :graphic {:fx/type :label
                            :text (str item)}
                  :content ((get tabs item) state)})))})) 
     
            ; {:fx/type :tab
            ;  :graphic {:fx/type :label
            ;            :text "Transactions"}
            ;  :closable false
            ;  :content {:fx/type :label
            ;            :text "tabby"}}

            ; {:fx/type :tab
            ;  :graphic {:fx/type :label
            ;            :text "Pull"}
            ;  :closable false
            ;  :content {:fx/type :label
            ;            :text "tabby"}}]}))          



(defmulti event-handler :event/type)

(defmethod event-handler ::set-friction [e]
  (println "DEF METHOD set friction")
  (swap! *state assoc :friction (:fx/event e)))


(defmethod event-handler ::yolo [e]
  (swap! *state assoc :input (:fx/event e)))

(defmethod event-handler ::fetch-entity [e]
  (println ::fetch-entity (:input @*state))
  (when-let [eid-str (:input @*state)]
    (println "EID STR" eid-str)
    (let [eid (Long. eid-str)
          res (d/pull (now) '[*] eid)]
      (swap! *state assoc :result res))))

(defmethod event-handler :default [e]
  (println "DEFAULT EVET" e))


(defn root-view [{state :state}]
  {:fx/type :stage
   :showing true
   :width 960
   :scene {:fx/type :scene
           :root {:fx/type :h-box
                  :children [
                             {:fx/type tab-pane
                              :state state
                              :items [:pull]}]}}})
                             


(def renderer
  (fx/create-renderer
    :middleware (fx/wrap-map-desc (fn [state]
                                    {:fx/type root-view
                                     :state state}))
    :opts {:fx.opt/map-event-handler event-handler}))

(comment)

(comment
  (fx/mount-renderer *state renderer))

(comment
  (+ 123 13))

