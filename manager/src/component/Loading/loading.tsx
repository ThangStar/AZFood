import styles from "../../../public/css/spiner.module.css";
export default function Loading() {
    // You can add any UI inside Loading, including a Skeleton.
    return (
        <div className={styles.overlay}>
            <div className={styles.spinner}></div>
        </div>
    )
}