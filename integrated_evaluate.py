from train import main as train_main
from translate import main as translate_main
import logging
import typer
import argparse
import os 

def main(log_file: str = typer.Option(None, help="Log file"),
            cuda: bool = typer.Option(True, help="Use a GPU"),
            data:str = 'data/en-fr/raw',
            dicts:str = 'data/en-fr/sp_all',
            source_lang:str = 'fr',
            target_lang:str = 'en',
            max_tokens:int = None,
            batch_size:int = 4,
            train_on_tiny:bool = False,
            arch:str = 'lstm',
            bpe:bool = True,
            bpe_dropout:float = 0.1,
            max_epoch:int = 10000,
            clip_norm:float = 4.0,
            lr:float = 0.0003,
            patience:int = 5,
            save_dir:str = 'assignments/03/bpe_dropout',
            restore_file:str = 'checkpoint_best.pt',
            save_interval:int = 1,
            no_save:bool = False,
            epoch_checkpoints:bool = False
    ):
    logging.basicConfig(filename=log_file, filemode='a', level=logging.INFO,
                        format='%(levelname)s: %(message)s')
    if log_file is not None:
        # Logging to console
        console = logging.StreamHandler()
        console.setLevel(logging.INFO)
        logging.getLogger('').addHandler(console)

    args = argparse.Namespace(cuda=cuda,
                              data=data,
                                dicts=dicts,
                              source_lang=source_lang,
                              target_lang=target_lang,
                              max_tokens=max_tokens,
                              batch_size=batch_size,
                              train_on_tiny=train_on_tiny,
                              arch=arch,
                              bpe=bpe,
                              bpe_dropout=bpe_dropout,
                              max_epoch=max_epoch,
                              clip_norm=clip_norm,
                              lr=lr,
                              patience=patience,
                              save_dir=save_dir,
                              restore_file=restore_file,
                              save_interval=save_interval,
                              no_save=no_save,
                              epoch_checkpoints=epoch_checkpoints)
    model_file = os.path.join(args.save_dir, args.restore_file)
    translations_output_file = os.path.join(args.save_dir, 'translations.txt')
    translate_args = argparse.Namespace(data=args.dicts,
                                        dicts=args.dicts,
                                        checkpoint_path=model_file,
                                        batch_size=256,
                                        output=translations_output_file,
                                        max_len=128,
                                        bpe=args.bpe,
                                        cuda=args.cuda,
                                        seed=42
    )
    translate_main(translate_args)
    #compute bleu score
    import sacrebleu
    with open(translations_output_file) as f:
        translations = f.readlines()
    with open(os.path.join('data/en-fr/raw', 'test.en')) as f:
        references = f.readlines()
    bleu = sacrebleu.corpus_bleu(translations, [references])
    print(bleu)



if __name__ == '__main__':
    typer.run(main)