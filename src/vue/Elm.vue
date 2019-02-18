<script>
    export default {
        name: "Elm",
        props: {
            elm: Object,
            flags: null
        },
        data() {
            return {
                app: null
            };
        },
        watch: {
            flags(newValue, _) {
                this.app.ports.getValue.send(newValue);
            }
        },
        mounted() {
            this.app = this.elm.init({
                node: this.$el,
                flags: this.flags
            });

            if (this.app.ports.sendValue) {
                this.app.ports.sendValue.subscribe(x => {
                    this.$emit('update:flags', x);
                });
            }
        },
        render(createElement, _) {
            return createElement("div");
        }
    };
</script>
