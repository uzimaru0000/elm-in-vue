<template>
    <div>
        <div>
            <input v-model="inputData">
            <button @click="addList">Add</button>
        </div>
        <elm :flags.sync="listData" :elm="elmApp"></elm>
    </div>
</template>

<script>
    import Elm from "./Elm";
    import ElmApp from "../Elm/Main.elm";

    export default {
        name: "App",
        components: {Elm},
        data() {
            return {
                inputData: "",
                listData: [],
                elmApp: ElmApp.Elm.Main
            };
        },
        methods: {
            addList() {
                this.listData = this.listData.concat(this.inputData);
                this.inputData = "";
            }
        }
    };
</script>
